import 'package:flutter/material.dart';
import 'package:my_notes/widgets/drop_down_button.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/individual_note.dart';

class NoteAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Function saveAndExit;

  const NoteAppBar(this.saveAndExit, this.appBar, {super.key});

  @override
  Size get preferredSize => appBar.preferredSize;

  @override
  State<NoteAppBar> createState() => _NoteAppBarState();
}

class _NoteAppBarState extends State<NoteAppBar> {
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    final initialValue = Provider.of<IndividualNote>(context,listen: false).title;
    return AppBar(
      leading: IconButton(
          onPressed: () {
            widget.saveAndExit();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      titleSpacing: 0,
      title: TextFormField(
        initialValue: initialValue,
        style: Theme.of(context)
            .appBarTheme
            .titleTextStyle!
            .copyWith(color: !_error ? Colors.white : Colors.red),
        onChanged: (value) {
          setState(() {
            _error = !Provider.of<IndividualNote>(context, listen: false)
                .updateTitle(value);
          });
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: !_error ? Colors.white : Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !_error ? Colors.white : Colors.red, width: 2),
            ),
            errorStyle: const TextStyle(height: 0),
            contentPadding: const EdgeInsets.all(3)),
      ),
      actions: const [AllignementSelector()],
    );
  }
}
