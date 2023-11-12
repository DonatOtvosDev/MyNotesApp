import 'package:flutter/material.dart';
import 'package:my_notes/providers/notes.dart';
import 'package:provider/provider.dart';

class NoteSearchField extends StatefulWidget {
  const NoteSearchField({super.key});

  @override
  State<NoteSearchField> createState() => _NoteSearchFieldState();
}

class _NoteSearchFieldState extends State<NoteSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8).copyWith(top: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface),
      child: Row(children: [
        Expanded(
            child: TextField(
              onChanged: (text) => Provider.of<Notes>(context, listen: false).updateFilter(text),
                decoration: const InputDecoration(
                    label: Text("Search"),
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 3))))),
        const Icon(
          Icons.search,
          color: Colors.black,
        )
      ]),
    );
  }
}
