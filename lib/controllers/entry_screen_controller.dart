import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgery_picker/models/patient_model.dart';
import 'package:surgery_picker/screens/patient_display_screen.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../constants.dart';

class EntryScreenController extends GetxController {
  final TextEditingController patientIdController = TextEditingController();
  final RxBool buttonClicked = false.obs;
  final RxBool isLoading = false.obs;

  void resetButtonClicked() {
    buttonClicked.value = false;
  }

  Future<void> handleSearch() async {
    buttonClicked.value = true;
    isLoading.value = true;

    var patientById = await FireStoreService()
        .getDocumentById(patientsCollection, patientIdController.text);
    isLoading.value = false;

    if (patientById != null && patientById.exists) {
      Get.to(PatientDisplayScreen(
          patientModel: PatientModel.fromSnapshot(patientById)));
    } else {
      Get.defaultDialog(
        title: "المريض غير موجود",
        middleText: "لا يوجد لدينا مريض بهذا الرقم، تأكد من صحته أولا",
        textConfirm: "حسناً",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );
    }
  }
}
