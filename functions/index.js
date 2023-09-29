/* eslint-disable */ 
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();
const stripe = require("stripe")(process.env.STRIPE_MAG);
const express = require("express");
const app = express();
const whitelist = ['https://storeglimpse-c926d.web.app/', 
                   'http://localhost', 
                   'https://us-central1-storeglimpse-c926d.cloudfunctions.net'];

exports.createCheckoutSession = functions.https.onRequest(async (req, res) => {
  try {
    const session = await stripe.checkout.sessions.create({
      client_reference_id: req.body.userID,
      customer_email: req.body.email,
      payment_method_types: ["card"],
      line_items: [
        {
          price: "price_1NpldVHt18Z95QJSDXRGlUjm",
          quantity: 1,
        },
      ],
      mode: "payment",
      success_url: "http://localhost:8000/#/success",
      cancel_url: "http://localhost:8000/#/cancel",
    });
    res.send({url: session.url});
  } catch (error) {
    log(error);
    res.status(500).send({error: error});
  }
});

// MIDDLEWARE IF NOT USING cors package 
app.use(function (req, res, next) {
    const origin = req.headers.origin || "";
  
    if (whitelist.indexOf(origin) !== -1) {
      res.setHeader('Access-Control-Allow-Origin', origin);
    } else {
      res.setHeader('Access-Control-Allow-Origin', '*'); // Allow all origin, may be removed if all request must be from whitelisted domain
    }
  
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Access-Control-Allow-Origin, Access-Control-Allow-Methods, Access-Control-Request-Method, Access-Control-Request-Headers, Access-Control-Allow-Headers,Origin, X-Requested-With, Content-Type, Accept, Authorization');
  
    res.setHeader('Access-Control-Allow-Credentials', true);
    if (req.method === "OPTIONS") {
      return res.status(200).json({});
    }
    next();
  });
  
// Use body-parser to retrieve the raw body as a buffer
const bodyParser = require('body-parser');

const endpointSecret = process.env.WH_SEC;

exports.webhook = functions.https.onRequest(async (request, response) => {
  const sig = request.headers['stripe-signature'];

  let event;

  try {
    event = stripe.webhooks.constructEvent(request.rawBody, sig, endpointSecret);
  } catch (err) {
    response.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  // Handle the event
  switch (event.type) {
    case 'checkout.session.async_payment_failed':
      const checkoutSessionAsyncPaymentFailed = event.data.object;
      // Define and call a function to handle the event checkout.session.async_payment_failed
      break;
    case 'checkout.session.async_payment_succeeded':
      const checkoutSessionAsyncPaymentSucceeded = event.data.object;
      // Define and call a function to handle the event checkout.session.async_payment_succeeded
      break;
    case 'checkout.session.completed':
      const checkoutSessionCompleted = event.data.object;
      const userID = checkoutSessionCompleted.client_reference_id;
      await admin.firestore().collection('users').doc(userID).update({
        paymentStatus: 'paid',
        paymentIntentID: checkoutSessionCompleted.payment_intent,
        checkoutSessionID: checkoutSessionCompleted.id,
      });
      break;
    case 'checkout.session.expired':
      const checkoutSessionExpired = event.data.object;
      // Define and call a function to handle the event checkout.session.expired
      break;
    // ... handle other event types
    default:
      console.log(`Unhandled event type ${event.type}`);
  }

  // Return a 200 response to acknowledge receipt of the event
  response.send();
});