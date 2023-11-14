import 'package:flutter/material.dart';

import 'package:my_notes/widgets/search_field.dart';
import 'package:my_notes/widgets/notes_list.dart';


import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Column(children: [
        NoteSearchField(),
        NotesList()
      ]),
    );
  }
}
