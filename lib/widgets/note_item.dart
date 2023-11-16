import 'package:flutter/material.dart';
import 'package:my_notes/modells/note_modell.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  final NoteData data;
  const NoteItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      margin:const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: primaryColor),
              ),
              Text(
                "Last modified: ${_convertDateToText(data.lastModified)}",
                style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(data.content, maxLines: 2, style: TextStyle(color: primaryColor, fontSize: 14),)
            ],
          ),
        ),
      ),
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
  } else if (const Duration(hours: 24) > dtNow.difference(date) && dtNow.day == date.day) {
    print((date.day, dtNow.day));
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
