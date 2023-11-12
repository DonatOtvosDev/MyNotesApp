import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String rootLink = "http://mynotes.wombat-tech.tk";

class UserAuth extends ChangeNotifier {
  String? _userName;
  String? _token;
  DateTime? _expiary;

  get token {
    if (_token == null) {
      return;
    } else if (DateTime.now().isAfter(_expiary!)) {
      return;
    }
    return _token;
  }

  get isAuthenticated {
    if (_token == null) {
      return false;
    } else if (DateTime.now().isAfter(_expiary!)) {
      return false;
    }
    return true;
  }

  Future<void> loginUser(Map<String, String> data) async {
    final url = Uri.parse("$rootLink/token");
    final response = await http.post(url, headers: {"Content-type": "application/x-www-form-urlencoded"}, body: "username=${data["username"]}&password=${data["password"]}");
    final responseData = json.decode(response.body);

    print(responseData);
    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }
  }
}
