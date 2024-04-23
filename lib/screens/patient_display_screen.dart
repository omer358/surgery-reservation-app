import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';
import 'package:surgery_picker/controllers/patient_display_controller.dart';
import 'package:surgery_picker/models/patient_model.dart';

class PatientDisplayScreen extends StatelessWidget {
  final PatientModel patientModel;
  final EntryScreenController _entryScreenController =
      Get.find<EntryScreenController>();
  final PatientDisplayController _patientDisplayController =
      Get.put(PatientDisplayController());

  PatientDisplayScreen({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات المريض"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 16, 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBasicPatientData(),
            const SizedBox(height: 20),
            _buildDiagnosisAndOperationInfo(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDatePicker(context),
              child: const Text("تحديد موعد العملية"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicPatientData() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildDataRow("الرقم التعريفي:", patientModel.id),
            const SizedBox(height: 20),
            _buildDataRow("الأسم:", patientModel.name),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisAndOperationInfo() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _buildDataRow("العملية المحددة:", patientModel.surgeryType),
            const SizedBox(height: 20),
            _buildDataRow("الطبيب:", patientModel.doctor),
            const SizedBox(height: 20),
            _buildOperationDate(),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationDate() {
    return Row(
      children: [
        const Text("تاريخ العملية:", style: TextStyle(fontSize: 16)),
        Obx(() {
          log(_entryScreenController.patient.value.toString());
          return Text(
            _entryScreenController.patient.value.specifiedDate.isEmpty
                ? "غير مُحدد"
                : _entryScreenController.patient.value.specifiedDate,
            style: const TextStyle(fontSize: 16),
          );
        }),
      ],
    );
  }

  Widget _buildDataRow(String title, String value) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        Text(value, style: const TextStyle(fontSize: 20)),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    _patientDisplayController.fetchAvailableSurgeryDates(patientModel.doctor);
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            const ListTile(
              title: Text('تواريخ متاحة:'),
            ),
            const Divider(),
            Obx(() => _patientDisplayController.formattedDates.isEmpty
                ? const CircularProgressIndicator()
                : _buildAvailableDatesList()),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableDatesList() {
    return ListView.builder(
      itemCount: _patientDisplayController.formattedDates.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String formattedDateTime =
            _patientDisplayController.formattedDates[index];
        String formattedDate = formattedDateTime.split(' - ')[0];
        String formattedTime = formattedDateTime.split(' - ')[1].split(' ')[0];
        return ListTile(
          title: Text(formattedDate),
          subtitle: Text(formattedTime),
          leading: const Icon(Icons.date_range),
          onTap: () {
            _patientDisplayController.reserveForSurgery(patientModel, index);
            Get.back();
          },
        );
      },
    );
  }
}
