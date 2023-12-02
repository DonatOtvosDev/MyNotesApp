import 'package:flutter/material.dart';
import 'package:my_notes/modells/note_modell.dart';
import 'package:intl/intl.dart';

import 'package:my_notes/screens/noteScreen.dart';

class NoteItem extends StatelessWidget {
  final NoteData data;
  final Function(int id) deleteNote;
  const NoteItem(this.deleteNote, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: primaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text(
                                        "Delete",
                                        style: Theme.of(context)
                                            .appBarTheme
                                            .titleTextStyle,
                                      ),
                                      content: const Text(
                                          "Are you sure you want to delete this note?"),
                                      actions: [
                                        TextButton.icon(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.white),
                                            label: const Text("Ok",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            }),
                                        TextButton.icon(
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                        )
                                      ],
                                    )).then(
                              (value) {
                                if (value) {
                                  deleteNote(data.id);
                                }
                              },
                            );
                          },
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).colorScheme.primary))
                    ],
                  ),
                ),
                Text(
                  "Last modified: ${_convertDateToText(data.lastModified)}",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data.content,
                  maxLines: 2,
                  style: TextStyle(color: primaryColor, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(NoteScreen.routeName,
          arguments: {"mode": "edit", "id": data.id}),
    );
  }
}

String _convertDateToText(DateTime date) {
  final DateTime dtNow = DateTime.now();
  if (const Duration(minutes: 2) > dtNow.difference(date)) {
    return "Just now";
  } else if (const Duration(minutes: 60) > dtNow.difference(date)) {
    final minutes = dtNow.difference(date).inMinutes.toStringAsFixed(0);
    return "$minutes minutes ago";
  } else if (const Duration(hours: 24) > dtNow.difference(date) &&
      dtNow.day == date.day) {
    final hours = dtNow.difference(date).inHours.toStringAsFixed(0);
    return "$hours hours ago";
  } else if (const Duration(hours: 24) > dtNow.difference(date)) {
    return "Yesterday";
  } else if (const Duration(days: 7) > dtNow.difference(date)) {
    return DateFormat.EEEE().format(date);
  } else {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
