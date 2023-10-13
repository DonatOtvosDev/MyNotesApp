import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appbar;
  const MyAppBar({required this.appbar, super.key});

  @override
  Size get preferredSize => appbar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      actions : [ Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(child: TextField(
              
            )),
            Icon(Icons.search)
          ]),
        ) ,]
        
    
    );
  }
}
