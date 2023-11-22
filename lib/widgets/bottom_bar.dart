import "package:flutter/material.dart";

import "package:my_notes/screens/noteScreen.dart";

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 0, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: IntrinsicWidth(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list,
                color: primaryColor,
                size: 25,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NoteScreen.routeName, arguments: {
                  "mode" : "add"
                });
              },
              icon: Icon(Icons.add_circle_outlined,color: primaryColor, size: 40)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: primaryColor,
                size: 25,
              ))
        ]),
      ),
    );
  }
}
