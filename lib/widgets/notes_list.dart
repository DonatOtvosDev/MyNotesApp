import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_notes/providers/notes.dart';

import 'package:my_notes/widgets/note_item.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  bool _didRun = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_didRun) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Notes>(context, listen: false).loadNotes().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _didRun = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              width: MediaQuery.of(context).size.width,
              child: Consumer<Notes>(
                  builder: (ctx, notes, _) => ListView.builder(
                      itemCount: notes.notes.length,
                      itemBuilder: (ctx, i) => NoteItem(notes.notes[i]))),
            ),
    );
  }
}
