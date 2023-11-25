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

  @override
  void didChangeDependencies() {
    if (!_didRun) {
      final titles = Provider.of<Notes>(context, listen: false).titles;
      Provider.of<IndividualNote>(context, listen: false).openNewNote(titles);
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _mode = arguments["mode"];
      if (_mode == "edit") {
        setState(() {
          _isLoading = true;
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
    print("disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: NoteAppBar(AppBar()),
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
    print(state);
    if (state == AppLifecycleState.inactive) {}
  }
}
