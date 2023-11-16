import 'package:flutter/material.dart';

import 'package:my_notes/widgets/note_app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: NoteAppBar(AppBar()),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
