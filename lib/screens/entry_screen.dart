import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surgery_picker/screens/patient_display_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "مرحبا بك في تطبيق حجز العمليات العيون",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  height: 150,
                ),
                SvgPicture.asset(
                  "assets/images/medical.svg",
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'ادخل رقم المريض التعريفي ',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientDisplayScreen()));
                    },
                    child: const Text("بحث", style: TextStyle(fontSize: 20),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
