import 'package:flutter/material.dart';

class AllignementSelector extends StatefulWidget {
  const AllignementSelector({super.key});

  @override
  State<AllignementSelector> createState() => _AllignementSelectorState();
}

class _AllignementSelectorState extends State<AllignementSelector> {
  final List<String> alignments = const ["right", "center", "left", "justify"];

  String currentValue = "right";

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
