import 'package:flutter/material.dart';

import 'package:my_notes/widgets/note_app_bar.dart';
import 'package:my_notes/widgets/note_content.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _isLoading = false;
  String title = "";
  String content = "";

  void _updateTitle(String newTitle) {
    title = newTitle;
  }

  void _updateContent(String newContent) {
    title = newContent;
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: NoteAppBar(_updateTitle, AppBar()),
            body: NoteContentEditor(_updateContent))
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
