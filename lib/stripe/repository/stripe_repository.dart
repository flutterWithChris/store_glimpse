import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:html' as html
  if (kIsWeb) 'dart:html';

class StripeRepository {
  Future<void> initiatePurchase(
      {required String userID, required String email}
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://us-central1-storeglimpse-c926d.cloudfunctions.net/createCheckoutSession'),
            body:  {
              'userID': userID,
              'email': email,
              }
      );
      final jsonResponse = jsonDecode(response.body);
      final url = jsonResponse['url'];
      if (await canLaunchUrlString(url)) {
        kIsWeb
            ? html.window.location.href = url
            : await launchUrlString(url);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Error initiating purchase');
    }
  }
}
