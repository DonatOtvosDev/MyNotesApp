import "package:flutter/material.dart";

import "package:my_notes/screens/noteScreen.dart";

import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes.dart';
import 'package:my_notes/providers/auth.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10)
          .copyWith(top: 0, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: IntrinsicWidth(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Consumer<Notes>(
              builder: (context, notesProvider, _) => TextButton(
                  onPressed: () {
                    notesProvider.changeSort();
                  },
                  child: Text(
                    notesProvider.sortedBy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ))),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NoteScreen.routeName,
                    arguments: {"mode": "add"});
              },
              icon: Icon(Icons.add_circle_outlined,
                  color: primaryColor, size: 40)),
          IconButton(
              onPressed: () {
                Provider.of<UserAuth>(context,listen: false).logOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: primaryColor,
                size: 25,
              ))
        ]),
      ),
    );
  }
}
