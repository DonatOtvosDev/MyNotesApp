import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/individual_note.dart';

class ErrorBar extends StatelessWidget {
  const ErrorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IndividualNote>(
        builder: (context, note, _) => Container(
              height: note.error == null ? 0 : null,
              padding: note.error == null ? null : const EdgeInsets.symmetric(horizontal: 10),
              decoration: note.error == null ? null : BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary,),
              child: Text(
                note.error ?? '',
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ));
  }
}
