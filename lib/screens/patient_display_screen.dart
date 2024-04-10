import 'package:flutter/material.dart';

class PatientDisplayScreen extends StatelessWidget {
  const PatientDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("بيانات المريض"),
      ),
      body: Center(
        child: Text("زول"),
      ),
    );
  }
}
