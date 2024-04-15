import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';
import 'package:surgery_picker/controllers/patient_display_controller.dart';
import 'package:surgery_picker/models/patient_model.dart';

class PatientDisplayScreen extends StatelessWidget {
  final PatientModel patientModel;
  final EntryScreenController entryScreenController = Get.find<EntryScreenController>();

  PatientDisplayScreen({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
    final PatientDisplayController controller =
        Get.put(PatientDisplayController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات المريض"),
      ),
      body: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 16, 8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "بيانات المريض الأساسية: ",
                style: TextStyle(fontSize: 24),
              ),
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "الرقم التعريفي: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            patientModel.id,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "الأسم: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            patientModel.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "معلومات التشخيص و العملية: ",
                style: TextStyle(fontSize: 24),
              ),
              Card(
                margin: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "العملية المحددة: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            patientModel.surgeryType,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "الطبيب: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            patientModel.doctor,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "تاريخ العملية: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Obx(() {
                            log(entryScreenController.patient.value.toString());
                            return Text(
                              entryScreenController
                                      .patient.value.specifiedDate.isEmpty
                                  ? "غير مُحدد"
                                  : entryScreenController
                                      .patient.value.specifiedDate,
                              style: const TextStyle(fontSize: 16),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _showDatePicker(context),
                child: const Text("تحديد موعد العملية"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    final PatientDisplayController controller =
        Get.find<PatientDisplayController>();
    controller.fetchData(patientModel.doctor);
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            const ListTile(
              title: Text('تواريخ متاحة:'),
            ),
            const Divider(),
            Obx(() => controller.formattedDates.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: controller.formattedDates.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String formattedDateTime =
                          controller.formattedDates[index];

                      // Assuming formattedDateTime is in the format "Month Day, Year"
                      // You can modify this based on your actual formatted date
                      String formattedDate = formattedDateTime
                          .split(' - ')[0]; // Extracting the date

                      // Extracting the time in hours
                      String formattedTime =
                          formattedDateTime.split(' - ')[1].split(' ')[0];
                      return ListTile(
                        title: Text(formattedDate),
                        subtitle: Text(formattedTime),
                        leading: const Icon(Icons.date_range),
                        onTap: () {
                          controller.reserveForSurgery(patientModel, index);
                          Get.back();
                        },
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
