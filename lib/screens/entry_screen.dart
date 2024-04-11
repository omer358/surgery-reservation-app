import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../constants.dart';

class EntryScreen extends StatelessWidget {
  EntryScreen({super.key});

  TextEditingController patientIdController = TextEditingController();

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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
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
                  controller: patientIdController,
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
                    onPressed: () async {
                      var patientById = await FireStoreService()
                          .getDocumentById(
                              patientsCollection, patientIdController.text);
                      if (patientById != null) {
                        print(patientById.data() as Map<String, dynamic>);
                      }
                    },
                    child: const Text(
                      "بحث",
                      style: TextStyle(fontSize: 20),
                    ),
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
