import 'package:flutter/material.dart';

import 'package:my_notes/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Column(children: [NoteSearchField()]),
    );
  }
}