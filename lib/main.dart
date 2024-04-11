import 'package:flutter/material.dart';
import 'package:surgery_picker/screens/entry_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
      locale: const Locale('ar'), // English language code with LTR direction
      home: const EntryScreen(),
    );
  }
}