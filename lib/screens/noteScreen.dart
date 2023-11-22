import 'package:flutter/material.dart';

import 'package:my_notes/widgets/note_app_bar.dart';
import 'package:my_notes/widgets/note_content.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  static const routeName = "/note";

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late String _mode;
  bool _isLoading = false;
  bool _didRun = false;

  @override
  void didChangeDependencies() {
    if (!_didRun) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _mode = arguments["mode"];

      if (_mode == "edit"){
        setState(() {
          _isLoading = true;
        });
      }
      setState(() {
        _didRun = true;
      });
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: NoteAppBar(AppBar()), body: const NoteContentEditor())
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
