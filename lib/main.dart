import 'package:flutter/material.dart';
import 'package:toneup/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Open Sans',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF003742),
      background: Colors.black,
      onBackground: Colors.white,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      home: const HomeScreen(),
    );
  }
}
