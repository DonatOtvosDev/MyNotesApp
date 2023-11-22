import 'package:flutter/material.dart';
import 'package:my_notes/widgets/drop_down_button.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/individual_note.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const NoteAppBar(this.appBar, {super.key});

  @override
  Size get preferredSize => appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      titleSpacing: 0,
      title: TextField(
        style: Theme.of(context).appBarTheme.titleTextStyle,
        onChanged: (value) {
          Provider.of<IndividualNote>(context, listen: false).updateTitle(value);
        },
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            contentPadding: EdgeInsets.all(3)),
      ),
      actions: const [
        AllignementSelector()
      ],
    );
  }
}
