import 'package:flutter/material.dart';

import 'package:my_notes/widgets/search_field.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(children: [
        NoteSearchField(),
        Consumer<Notes>(
            builder: (ctx, notes, _) => Text(notes.filter ?? "None"))
      ]),
    );
  }
}
