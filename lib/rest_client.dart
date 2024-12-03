import 'dart:convert';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thedailylingo/email_request.dart';

import 'Constants.dart';

Future<Response> verifyEmailIdRequest(String emailId) async {

  final chuckerHttpClient = ChuckerHttpClient(http.Client());
  return await chuckerHttpClient.post(
      Uri.parse('$BASE_URL$VERIFY_URL_PATH'),
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(EmailRequest(email: emailId).toJson())
  );
}