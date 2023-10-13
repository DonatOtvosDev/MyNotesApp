import 'package:flutter/material.dart';

class NoteSearchField extends StatelessWidget {
  const NoteSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface),
      child: const Row(children: [
        Expanded(child:TextField(decoration: InputDecoration(label: Text("Search"), labelStyle: TextStyle(fontSize: 20, color: Colors.black), border: UnderlineInputBorder(borderSide: BorderSide(width: 3))))),
        Icon(Icons.search, color: Colors.black,)
      ]),
    );
  }
}
