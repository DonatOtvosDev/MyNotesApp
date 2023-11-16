import 'package:flutter/material.dart';

class NoteAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const NoteAppBar(this.appBar, {super.key});

  @override
  Size get preferredSize => appBar.preferredSize;

  @override
  State<NoteAppBar> createState() => _NoteAppBarState();
}

class _NoteAppBarState extends State<NoteAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      titleSpacing: 0,
      title: TextField(
        style: Theme.of(context).appBarTheme.titleTextStyle,
        controller: _controller,
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
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save, color: Colors.white)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_drop_down, color: Colors.white))
      ],
    );
  }
}
