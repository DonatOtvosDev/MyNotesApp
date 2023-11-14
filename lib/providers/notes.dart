import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String rootLink = "http://mynotes.wombat-tech.tk";

class Notes extends ChangeNotifier {
  String? _filter;

  String? authToken;

  Notes(this.authToken);

  String? get filter {
    return _filter;
  }

  Future<void> loadNotes() async {
    if (authToken == null) return;
    final url = Uri.parse("$rootLink/user");
    final response = await http.get(url, headers: {"Authorization": "Bearer $authToken"});
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }
    print(responseData);
  }

  void updateFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }
}