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
const stripe = require("stripe")(process.env.STRIPE_MAG);
const express = require("express");
const app = express();
const whitelist = ['https://storeglimpse-c926d.web.app/', 
                   'http://localhost', 
                   'https://us-central1-storeglimpse-c926d.cloudfunctions.net'];

exports.createCheckoutSession = functions.https.onRequest(async (req, res) => {
  try {
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items: [
        {
          price: "price_1NpldVHt18Z95QJSDXRGlUjm",
          quantity: 1,
        },
      ],
      mode: "payment",
      success_url: "https://storeglimpse-c926d.web.app/success",
      cancel_url: "https://storeglimpse-c926d.web.app/cancel",
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
  
