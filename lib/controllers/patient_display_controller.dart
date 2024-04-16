import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:surgery_picker/constants.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';
import 'package:surgery_picker/models/doctor_model.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../models/patient_model.dart';

class PatientDisplayController extends GetxController {
  final RxList<String> formattedDates = <String>[].obs;
  final EntryScreenController _entryScreenController =
      Get.find<EntryScreenController>();
  final Rx<DoctorModel> doctorModel = const DoctorModel(id: '', name: '', availableDates: []).obs;

  Future<void> fetchAvailableSurgeryDates(String doctorName) async {
    final listOfDocuments = await FireStoreService()
        .getDocumentsByField(doctorsCollection, "name", doctorName);
    var doctorMap = List.generate(
            listOfDocuments.length, (index) => listOfDocuments[index].data())
        .first!;
    log(doctorMap.toString());
    doctorModel.value = DoctorModel.fromSnapshot(listOfDocuments.first);
    final List<dynamic> availableDates = doctorModel.value.availableDates;

    // Format timestamps
    formattedDates.assignAll(availableDates.map<String>((timestamp) {
      final DateTime dateTime = timestamp.toDate();
      String formattedDateTime =
          DateFormat('EEEE, dd MMMM - HH:mm', 'ar').format(dateTime);
      return formattedDateTime;
    }).toList());
  }

  void reserveForSurgery(PatientModel patient, int index) {
    _entryScreenController.patient.value =
        patient.copyWith(specifiedDate: formattedDates[index]);
    FireStoreService().updateData(_entryScreenController.patient.value.toMap(),
        patient.id, patientsCollection);
    var remainDates = doctorModel.value.availableDates;
    remainDates.removeAt(index);
    log(remainDates.toString());
    doctorModel.value = doctorModel.value.copyWith(availableDates: remainDates);
    Map<String, List<dynamic>> updatedData = {"avilable_dates": doctorModel.value.availableDates};
    FireStoreService().updateData(updatedData, doctorModel.value.id, "doctors");
    /**
     * fetch the doctor document based on the entered patient
     * update the doctor document after the patient pick a surgery date, remove the selected date from the doctor document
     *
     */
  }
}
