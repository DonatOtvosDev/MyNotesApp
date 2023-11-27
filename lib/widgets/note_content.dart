import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/individual_note.dart';

class NoteContentEditor extends StatelessWidget {
  const NoteContentEditor({super.key});


  @override
  Widget build(BuildContext context) {
    final initialValue = Provider.of<IndividualNote>(context,listen: false).content;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        onChanged: (value) {
          Provider.of<IndividualNote>(context, listen: false).updateContent(value);
        },
        cursorColor: Colors.white,
        expands: true,
        maxLines: null,
        textAlign: Provider.of<IndividualNote>(context).noteAlignement,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
