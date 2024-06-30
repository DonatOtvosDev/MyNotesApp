import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_notes/modells/note_modell.dart';

const String rootLink = "http://donatdev.tech:9000";

class IndividualNote extends ChangeNotifier {
  int? _id;
  String? _title;
  String? _content;
  DateTime? _lastModified;
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
    _lastModified = null;
    _titleList = titles;
    _noteAlignement = TextAlign.left;
  }

  Future<NoteData> saveNote() async {
    if (authToken == null) throw "Unauthorized";
    _content ??= "";
    Uri? url;
    Map args = {"title": _title, "content": _content};
    if (_id == null) {
      url = Uri.parse("$rootLink/createnote");
    } else {
      url = Uri.parse("$rootLink/updatenote");
      args["id"] = _id;
    }

    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-type": "application/json"
        },
        body: json.encode(args));
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }

    _id = responseData["id"];
    _title = responseData["title"]!;
    _content = responseData["content"]!;
    _lastModified = _pharseTimeToUtc(responseData["last_modified"]!);

    return NoteData(
        id: _id!,
        title: _title!,
        content: _content!,
        lastModified: _lastModified!);
  }

  Future<void> loadNote(int id) async {
    if (authToken == null) return;
    final url = Uri.parse("$rootLink/note/$id");
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $authToken"});
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }

    _id = responseData["id"]!;
    _title = responseData["title"]!;
    _content = responseData["content"]!;
    _lastModified = _pharseTimeToUtc(responseData["last_modified"]!);
    _titleList.remove(_title);
    notifyListeners();
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
