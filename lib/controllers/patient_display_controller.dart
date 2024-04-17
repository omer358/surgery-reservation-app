import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:surgery_picker/constants.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';
import 'package:surgery_picker/models/doctor_model.dart';
import 'package:surgery_picker/services/firestore_service.dart';

import '../models/patient_model.dart';

class PatientDisplayController extends GetxController {
  /// List of formatted surgery dates.
  final RxList<String> formattedDates = <String>[].obs;

  /// EntryScreenController instance for accessing patient data.
  final EntryScreenController _entryScreenController =
  Get.find<EntryScreenController>();

  /// DoctorModel instance for storing doctor data.
  final Rx<DoctorModel> doctorModel = const DoctorModel(
    id: '',
    name: '',
    availableDates: [],
  ).obs;

  /// Fetches available surgery dates for the specified doctor.
  ///
  /// Parameters:
  /// - [doctorName]: Name of the doctor to fetch available dates for.
  ///
  /// Returns: Future<void>.
  ///
  /// Throws: Exception if there's an error fetching data.
  Future<void> fetchAvailableSurgeryDates(String doctorName) async {
    try {
      final listOfDocuments = await FireStoreService()
          .getDocumentsByField(doctorsCollection, "name", doctorName);
      final doctorData = listOfDocuments.isNotEmpty ? listOfDocuments.first.data() : null;

      if (doctorData != null) {
        doctorModel.value = DoctorModel.fromSnapshot(listOfDocuments.first);
        final List<dynamic> availableDates = doctorModel.value.availableDates;
        _formatDates(availableDates);
      } else {
        log("Doctor not found with name: $doctorName");
      }
    } catch (e) {
      log("Error fetching available surgery dates: $e");
    }
  }

  /// Formats the retrieved dates into a human-readable format.
  ///
  /// Parameters:
  /// - [dates]: List of timestamps representing available surgery dates.
  ///
  /// Returns: void.
  void _formatDates(List<dynamic> dates) {
    formattedDates.assignAll(dates.map<String>((timestamp) {
      final DateTime dateTime = timestamp.toDate();
      return DateFormat('EEEE, dd MMMM - HH:mm', 'ar').format(dateTime);
    }).toList());
  }

  /// Reserves a surgery appointment for the patient.
  ///
  /// Parameters:
  /// - [patient]: PatientModel object representing the patient.
  /// - [index]: Index of the selected surgery date.
  ///
  /// Returns: void.
  void reserveForSurgery(PatientModel patient, int index) {
    _updatePatientSpecifiedDate(patient, index);
    _updateDoctorAvailableDates(index);
  }

  /// Updates the patient's specified surgery date.
  ///
  /// Parameters:
  /// - [patient]: PatientModel object representing the patient.
  /// - [index]: Index of the selected surgery date.
  ///
  /// Returns: void.
  void _updatePatientSpecifiedDate(PatientModel patient, int index) {
    final String selectedDate = formattedDates[index];
    _entryScreenController.patient.value =
        patient.copyWith(specifiedDate: selectedDate);
    FireStoreService().updateData(
        _entryScreenController.patient.value.toMap(), patient.id, patientsCollection);
  }

  /// Updates the doctor's available surgery dates.
  ///
  /// Parameters:
  /// - [index]: Index of the selected surgery date.
  ///
  /// Returns: void.
  void _updateDoctorAvailableDates(int index) {
    var remainingDates = doctorModel.value.availableDates;
    remainingDates.removeAt(index);
    doctorModel.value = doctorModel.value.copyWith(availableDates: remainingDates);
    _updateDoctorDocument();
  }

  /// Updates the doctor document in Firestore with the new available dates.
  ///
  /// Returns: void.
  void _updateDoctorDocument() {
    Map<String, List<dynamic>> updatedData = {
      "avilable_dates": doctorModel.value.availableDates
    };
    FireStoreService().updateData(updatedData, doctorModel.value.id, "doctors");
  }
}
