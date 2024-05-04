import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:surgery_picker/firebase_options.dart';
import 'package:surgery_picker/screens/entry_screen.dart';

Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('ar');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: "Rubik",
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        fontFamily: "Rubik",
      ),
      locale: const Locale('ar'), // English language code with LTR direction
      home:  EntryScreen(),
    );
  }
}
