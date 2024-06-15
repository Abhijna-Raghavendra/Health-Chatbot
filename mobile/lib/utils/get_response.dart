import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getResponse(String message) async {
  final response = await http.post(
    Uri.parse(
        'http://192.168.47.26:5000/chat'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode(<String, String>{
      "message": message,
    }),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    debugPrint(response.statusCode.toString());
    throw Exception('Failed to load album');
  }
}