import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:surgery_picker/models/patient_model.dart';
import 'package:surgery_picker/services/notification_service.dart';

class PatientDisplayScreen extends StatelessWidget {
  final PatientModel patientModel;
   const PatientDisplayScreen({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
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
                  child:  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "العملية المحددة: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            patientModel.surgeryType,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "الطبيب: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            patientModel.doctor,
                            style: const TextStyle(fontSize: 18),
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
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            patientModel.specifiedDate,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox( height: 20,),
              ElevatedButton(onPressed: () async{
                final date = await showRangePickerDialog(
                  context: context,
                  minDate: DateTime(2021, 1, 1),
                  maxDate: DateTime(2023, 12, 31),
                );
                NotificationService().showNotification(title: "زمن العملية", body: date.toString());
              }, child: const Text("تحديد موعد العملية"))
            ],
          ),
        ),
      ),
    );
  }
}
