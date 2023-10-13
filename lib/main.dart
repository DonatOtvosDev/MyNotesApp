import 'package:flutter/material.dart';

import 'package:my_notes/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //https://colorhunt.co/palette/0b244719376d576cbca5d7e8
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNotesApp',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color.fromRGBO(25, 55, 109, 1),
          secondary: Color.fromRGBO(87, 108, 188, 1),
          surface: Color.fromRGBO(165, 215, 232, 1),
          background: Color.fromRGBO(25, 55, 109, 1),
          error: Colors.red,
          onPrimary: Colors.black54,
          onSecondary: Colors.black38,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.grey,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color.fromRGBO(241, 246, 249, 1), fontSize: 16)),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(87, 108, 188, 1),
            titleTextStyle: TextStyle(
                color: Color.fromRGBO(241, 246, 249, 1),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito')),
        fontFamily: 'Nunito',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
