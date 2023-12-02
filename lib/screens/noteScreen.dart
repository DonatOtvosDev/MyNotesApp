import 'package:flutter/material.dart';

import 'package:my_notes/widgets/note_app_bar.dart';
import 'package:my_notes/widgets/note_content.dart';
import 'package:my_notes/widgets/error_bar.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes.dart';
import 'package:my_notes/providers/individual_note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  static const routeName = "/note";

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with WidgetsBindingObserver {
  late String _mode;
  bool _isLoading = false;
  bool _didRun = false;

  Future<void> _saveNote() async {
    setState(() {
      _isLoading = true;
    });
    final newNote =
        await Provider.of<IndividualNote>(context, listen: false).saveNote();
    if(!mounted) return;
    Provider.of<Notes>(context, listen: false).updateNotes(newNote);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (!_didRun) {
      final titles = Provider.of<Notes>(context).titles;
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _mode = arguments["mode"];
      Provider.of<IndividualNote>(context, listen: false).openNewNote(titles);
      if (_mode == "edit") {
        int id = arguments["id"];
        setState(() {
          _isLoading = true;
        });
        Provider.of<IndividualNote>(context, listen: false)
            .loadNote(id)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } else if (_mode == "add") {
        Provider.of<IndividualNote>(context, listen: false)
            .generateInitialValue();
      }
      setState(() {
        _didRun = true;
      });
      super.didChangeDependencies();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: NoteAppBar(_saveNote,AppBar()),
            body: const NoteContentEditor(),
            floatingActionButton: const ErrorBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      _saveNote();
    }
  }
}
