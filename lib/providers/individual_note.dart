import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

const String rootLink = "http://mynotes.wombat-tech.tk";

class IndividualNote extends ChangeNotifier {
  int? _id;
  String? _title;
  String? _content;
  //DateTime? _lastModified;
  String? _error;

  List<String> _titleList = [];

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

  String? get error {
    return _error;
  }

  bool updateTitle(String? title) {
    bool returnValue = true;
    if (title == null || title == "") {
      _error = "Title cannot be empty";
      returnValue = false;
    } else if (_titleList.contains(title.trim())) {
      _error = "Note already exists with this title";
      returnValue = false;
    } else if (title.contains(RegExp("[^a-zA-z0-9áéíóöőúüűÁÉÍÓÖŐÚÜŰ ]"))) {
      _error = "Invalid character is used";
      returnValue = false;
    } else {
      _title = title;
      _error = null;
    }
    notifyListeners();
    return returnValue;
  }

  void updateContent(String content) {
    _content = content;
  }

  void openNewNote(List<String> titles) {
    _id = null;
    _title = null;
    _content = null;
    //_lastModified = null;
    _titleList = titles;
    _noteAlignement = TextAlign.left;
  }

  Future<void> saveNote() async {
    if (_id == null) {}
  }

  void generateInitialValue() {
    String defaultTitle = "Title";
    int index = 1;
    while (_titleList.contains(("$defaultTitle$index").trim())) {
      index += 1;
    }
    _title = "$defaultTitle$index";
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
