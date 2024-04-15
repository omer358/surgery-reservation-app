import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:surgery_picker/constants.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../models/patient_model.dart';

class PatientDisplayController extends GetxController {
  final RxList<String> formattedDates = <String>[].obs;
  final EntryScreenController _entryScreenController =
      Get.find<EntryScreenController>();

  Future<void> fetchData(String doctorName) async {
    final listOfDocuments = await FireStoreService()
        .getDocumentsByField(doctorsCollection, "name", doctorName);
    final firstData = List.generate(
        listOfDocuments.length, (index) => listOfDocuments[index].data()).first;
    final List<dynamic> availableDates = firstData?["avilable_dates"];

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
  }
}
