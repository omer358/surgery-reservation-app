import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:surgery_picker/firebase_options.dart';
import 'package:surgery_picker/screens/entry_screen.dart';
import 'package:surgery_picker/services/notification_service.dart';


Future<void> main() async{
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), fontFamily: "Rubik"),
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
      locale: const Locale('ar'), // English language code with LTR direction
      home:  EntryScreen(),
    );
  }
}