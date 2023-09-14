import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class StripeRepository {
  Future<void> initiatePurchase() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://us-central1-storeglimpse-c926d.cloudfunctions.net/createCheckoutSession'),
      );
      final jsonResponse = jsonDecode(response.body);
      final url = jsonResponse['url'];
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Error initiating purchase');
    }
  }
}
