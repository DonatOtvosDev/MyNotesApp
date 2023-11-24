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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      titleSpacing: 0,
      title: TextFormField(
        style: Theme.of(context).appBarTheme.titleTextStyle,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (Provider.of<IndividualNote>(context, listen: false)
              .updateTitle(value) == false) return '';
          return null;
        },
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            errorStyle: TextStyle(height: 0),
            contentPadding: EdgeInsets.all(3)),
      ),
      actions: const [AllignementSelector()],
    );
  }
}
