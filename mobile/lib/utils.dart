import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

dynamic getUri(String route){
  return Uri.parse('http://192.168.1.156:5000/${route}');
}

Future<String> chat(String message) async {
  final response = await http.post(
    getUri('/chat'),
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

Future<String> signup(Map<String, String> m) async {
  final response = await http.post(
    getUri('/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode(m),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    debugPrint(response.statusCode.toString());
    throw Exception('Failed to load album');
  }
}

Future<String> signin(Map<String, String> m) async {
  final response = await http.post(
    getUri('/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode(m),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    debugPrint(response.statusCode.toString());
    throw Exception('Failed to load album');
  }
}