import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_notes/modells/note_modell.dart';

const String rootLink = "http://mynotes.wombat-tech.tk";

class Notes extends ChangeNotifier {
  String? _filter;

  List<NoteData> _notes = [];

  String? authToken;

  Notes(this.authToken);

  String? get filter {
    return _filter;
  }

  List<String> get titles {
    return _notes.map((note) => note.title).toList();
  }

  List<NoteData> get notes {
    List<NoteData> notesToReturn = [];
    if (_filter == null || _filter == "") return _notes;
    RegExp filterRegex = RegExp((_filter! + r".*"));
    for (NoteData note in _notes) {
      if (filterRegex.firstMatch(note.title) != null &&
          _filter!.characters.first == note.title.characters.first) {
        notesToReturn.add(note);
      }
    }
    return notesToReturn;
  }

  Future<void> loadNotes() async {
    if (authToken == null) return;
    final url = Uri.parse("$rootLink/user");
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $authToken"});
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }
    final rawNotes = responseData["notes"] as List;

    _notes = [];
    for (Map<String, dynamic> nt in rawNotes) {
      _notes.add(NoteData(
          id: nt["id"],
          title: nt["title"],
          content: nt["content"],
          lastModified: _pharseTimeToUtc(nt["last_modified"])));
    }
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    if (authToken == null) return;
    final url = Uri.parse("$rootLink/deletenote");
    final response = await http.delete(url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-type": "application/json"
        },
        body: json.encode({"id": id}));
    final responseData = json.decode(response.body);

    if (!(response.statusCode < 400)) {
      throw responseData["detail"];
    }

    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void updateNotes(NoteData newNote) {
    for (int i = 0; i < _notes.length; i++) {
      if (_notes[i].id == newNote.id) {
        _notes[i] = newNote;
        notifyListeners();
        return;
      }
    }
    _notes.add(newNote);
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
