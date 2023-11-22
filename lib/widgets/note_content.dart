import 'package:flutter/material.dart';

class NoteContentEditor extends StatelessWidget {
  final Function changeContent;
  const NoteContentEditor(this.changeContent, {super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(12),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 18),
        onChanged: (value) {changeContent(value);},
        cursorColor: Colors.white,
        expands: true,
        maxLines: null,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
