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
      Provider.of<Notes>(context, listen: false)
          .loadNotes()
          .then((_) {
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
      child: _isLoading ? const Center(child: CircularProgressIndicator(),) : Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 50, itemBuilder: (ctx, i) => NoteItem()),
        
      ),
    );
  }
}
