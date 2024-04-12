import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surgery_picker/models/patient_model.dart';
import 'package:surgery_picker/screens/patient_display_screen.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../constants.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController patientIdController = TextEditingController();
  bool buttonClicked = false; // Track whether the button has been clicked
  bool isLoading = false; // Track whether the app is loading

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
                const SizedBox(height: 100,),
                _buildHeaderText(),
                const SizedBox(height: 20,),
                _buildSvgImage(),
                const SizedBox(height: 20,),
                _buildTextField(),
                const SizedBox(height: 20),
                _buildSearchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        "مرحبا بك في تطبيق حجز العمليات العيون",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      "assets/images/medical.svg",
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: patientIdController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textDirection: TextDirection.rtl,
      onTap: _resetButtonClicked,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: 'ادخل رقم المريض التعريفي ',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        // Show error message only when button is clicked
        errorText: buttonClicked &&
            (patientIdController.text.isEmpty ||
                double.tryParse(patientIdController.text) == null)
            ? 'يجب إدخال رقم المريض التعريفي أولاً'
            : null,
      ),
    );
  }

  Widget _buildSearchButton() {
    return isLoading
        ? const CircularProgressIndicator()
        : Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: _handleSearch,
        child: const Text(
          "بحث",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _resetButtonClicked() {
    setState(() {
      buttonClicked = false;
    });
  }

  Future<void> _handleSearch() async {
    setState(() {
      buttonClicked = true;
      isLoading = true;
    });
    var patientById = await FireStoreService()
        .getDocumentById(patientsCollection, patientIdController.text);
    setState(() {
      isLoading = false;
    });
    if (patientById != null && patientById.exists) {
      _navigateToPatientDisplayScreen(patientById);
    } else {
      log("no patient with this number");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text("المريض غير موجود"),
              content: const Text("لا يوجد لدينا مريض بهذا الرقم، تأكد من صحته اولا"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("حسناً"),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _navigateToPatientDisplayScreen(DocumentSnapshot<Map<String, dynamic>> patientSnapshot) {
    PatientModel patient = PatientModel.fromSnapshot(patientSnapshot);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientDisplayScreen(
          patientModel: patient,
        ),
      ),
    );
    patientIdController.clear();
  }
}
