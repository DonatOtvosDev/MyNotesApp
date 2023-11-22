import 'package:flutter/material.dart';
import 'package:my_notes/widgets/drop_down_button.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Function updateTitle;

  const NoteAppBar(this.updateTitle, this.appBar, {super.key});

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
          updateTitle(value);
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
      actions: [
        AllignementSelector()
      ],
    );
  }
}
