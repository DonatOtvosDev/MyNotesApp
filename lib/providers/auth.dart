import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const String rootLink = "http://mynotes.wombat-tech.tk";

class UserAuth extends ChangeNotifier {
  String? _userName;
  String? _token;
  DateTime? _expiary;

  Timer? _authTimer;

  String? get token {
    if (_token == null) {
      return null;
    } else if (DateTime.now().isAfter(_expiary!)) {
      return null;
    }
    return _token;
  }

  bool get isAuthenticated {
    if (_token == null) {
      return false;
    } else if (DateTime.now().toUtc().isAfter(_expiary!)) {
      return false;
    }
    return true;
  }

  String? get username {
    return _userName;
  }

  Future<void> loginUser(Map<String, String> data) async {
    final url = Uri.parse("$rootLink/token");
    final response = await http.post(url,
        headers: {"Content-type": "application/x-www-form-urlencoded"},
        body: "username=${data["username"]}&password=${data["password"]}");
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }

    _token = responseData["access_token"];
    _expiary = _pharseTimeToUtc(responseData["expiary"]);
    _userName = data["username"];
    notifyListeners();
  }

  Future<void> register(Map<String, String> data) async {
    final url = Uri.parse("$rootLink/register");
    final response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: json.encode(data));
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }

    loginUser(data);
  }

  void _autoRefreshToken(Map<String, String> data) {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToNewLogin = _expiary!.difference(
        DateTime.now().toUtc().subtract(const Duration(seconds: 30)));
    _authTimer = Timer(timeToNewLogin, () => loginUser(data));
  }

  DateTime _pharseTimeToUtc(String timeAsString) {
    final dtToConvert = DateTime.parse(timeAsString);
    //convering the locally phased datetime to utc
    DateTime utcTime = DateTime.utc(
        dtToConvert.year,
        dtToConvert.month,
        dtToConvert.day,
        dtToConvert.hour,
        dtToConvert.minute,
        dtToConvert.second,
        dtToConvert.microsecond);
    return utcTime;
  }
}
