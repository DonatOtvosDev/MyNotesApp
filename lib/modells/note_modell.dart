import 'dart:ffi';

class NoteData {
  Int id;
  String title;
  String content;
  DateTime lastModified;
  NoteData({
    required this.id,
    required this.title,
    required this.content,
    required this.lastModified,
  });
}