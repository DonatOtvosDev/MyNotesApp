import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/individual_note.dart';

class AllignementSelector extends StatefulWidget {
  const AllignementSelector({super.key});

  @override
  State<AllignementSelector> createState() => _AllignementSelectorState();
}

class _AllignementSelectorState extends State<AllignementSelector> {
  final List<String> alignments = const ["left", "center", "right", "justify"];

  String currentValue = "left";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownButton(
        icon: alignementIcon(currentValue),
        items: alignments
            .map((allign) =>
                DropdownMenuItem(value: allign, child: alignementIcon(allign)))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              currentValue = value;
              Provider.of<IndividualNote>(context, listen: false)
                  .changeTextAlign(value);
            });
          }
        },
        underline: const SizedBox(),
      ),
    );
  }
}

Icon alignementIcon(String key) {
  switch (key) {
    case "right":
      return const Icon(
        Icons.align_horizontal_right,
        color: Colors.white,
      );
    case "center":
      return const Icon(
        Icons.align_horizontal_center,
        color: Colors.white,
      );
    case "left":
      return const Icon(
        Icons.align_horizontal_left,
        color: Colors.white,
      );
    case "justify":
      return const Icon(
        Icons.format_align_justify,
        color: Colors.white,
      );
  }
  return const Icon(Icons.error);
}
