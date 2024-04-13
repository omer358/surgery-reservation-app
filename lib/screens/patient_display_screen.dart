import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intle;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:surgery_picker/constants.dart';
import 'package:surgery_picker/models/patient_model.dart';
import 'package:surgery_picker/services/firestore_service.dart';

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
                          Text(
                            patientModel.specifiedDate.isEmpty
                                ? "غير مُحدد"
                                : patientModel.specifiedDate,
                            style: const TextStyle(fontSize: 16),
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
              ElevatedButton(
                  onPressed: () async {
                    var fetchData = await _fetchData();
                    List<dynamic> availableDates = fetchData?["avilable_dates"];
                    print(availableDates);
                    // Format timestamps
                    List<String> formattedDates =
                        availableDates.map((timestamp) {
                      DateTime dateTime = timestamp.toDate();
                      String formattedDate =
                          intle.DateFormat('EEEE, MMM dd, yyyy').format(dateTime);
                      return formattedDate;
                    }).toList();
                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              padding: const EdgeInsets.all(8),
                              child: ListView.builder(
                                  itemBuilder: (buildContext, index) =>
                                      ListTile(
                                        title: Text(formattedDates[index]),
                                        leading: Icon(Icons.date_range),
                                        onTap: () {},
                                      ),
                                  itemCount: formattedDates.length),
                            ));
                  },
                  child: const Text("تحديد موعد العملية"))
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _fetchData() async {
    var listOfDocuments = await FireStoreService()
        .getDocumentsByField(doctorsCollection, "name", patientModel.doctor);
    return List.generate(
        listOfDocuments.length, (index) => listOfDocuments[index].data()).first;
  }
}
