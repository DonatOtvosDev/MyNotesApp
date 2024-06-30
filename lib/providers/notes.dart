import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_notes/modells/note_modell.dart';

const String rootLink = "http://donatdev.tech:9000";

enum SortTypes { aToZ, zToA, latestToOldest, oldestToLatest }

class Notes extends ChangeNotifier {
  String? _filter;
  SortTypes _sortBy = SortTypes.aToZ;

  final List<SortTypes> _sortingOptions = [
    SortTypes.aToZ,
    SortTypes.zToA,
    SortTypes.latestToOldest,
    SortTypes.oldestToLatest
  ];

  List<NoteData> _notes = [];

  String? authToken;

  Notes(this.authToken);

  String? get filter {
    return _filter;
  }

  List<String> get titles {
    return _notes.map((note) => note.title).toList();
  }

  String get sortedBy {
    switch (_sortBy) {
      case SortTypes.aToZ:
        return "AtoZ";
      case SortTypes.zToA:
        return "ZtoA";
      case SortTypes.latestToOldest:
        return "Latest";
      case SortTypes.oldestToLatest:
        return "Oldest";
    }
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
    _sortNotes();
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
        _sortNotes();
        notifyListeners();
        return;
      }
    }
    _notes.add(newNote);
    _sortNotes();
    notifyListeners();
  }

  void changeSort() {
    if (_sortingOptions.indexOf(_sortBy) < (_sortingOptions.length - 1)) {
      _sortBy = _sortingOptions[_sortingOptions.indexOf(_sortBy) + 1];
    } else {
      _sortBy = _sortingOptions.first;
    }
    _sortNotes();
    notifyListeners();
  }

  void _sortNotes() {
    if (_sortBy == SortTypes.aToZ) {
      _notes.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == SortTypes.zToA) {
      _notes.sort((a, b) => b.title.compareTo(a.title));
    } else if (_sortBy == SortTypes.oldestToLatest) {
      _notes.sort((a, b) => a.lastModified.compareTo(b.lastModified));
    } else if (_sortBy == SortTypes.latestToOldest) {
      _notes.sort((a, b) => b.lastModified.compareTo(a.lastModified));
    }
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
