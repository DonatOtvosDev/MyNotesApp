import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

const String rootLink = "http://mynotes.wombat-tech.tk";

class IndividualNote extends ChangeNotifier {
  //int? _id;
  String? _title;
  String? _content;
  //DateTime? _lastModified;

  String? authToken;

  IndividualNote(this.authToken);

  TextAlign _noteAlignement = TextAlign.left;

  TextAlign get noteAlignement {
    return _noteAlignement;
  }

  String? get title {
    return _title;
  }

  String? get content {
    return _content;
  }

  void updateTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void updateContent(String content) {
    _content = content;
    notifyListeners();
  }

  void changeTextAlign(String alignement) {
    switch (alignement) {
      case "right":
        _noteAlignement = TextAlign.right;
      case "center":
        _noteAlignement = TextAlign.center;
      case "left":
        _noteAlignement = TextAlign.left;
      case "justify":
        _noteAlignement = TextAlign.justify;
    }
    notifyListeners();
  }
}
