import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

class PatientDisplayScreen extends StatelessWidget {
  const PatientDisplayScreen({super.key});

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
              const Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "الرقم التعريفي: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "1234",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "الأسم: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "عمر مكي ",
                            style: TextStyle(fontSize: 20),
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
                          Text(
                            "العملية المحددة: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "ACL Tear",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "الطبيب: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "محمد علي سعد",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "تاريخ العملية: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "غير محدد",
                            style: TextStyle(fontSize: 18),
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
                print(date);
              }, child: const Text("تحديد موعد العملية"))
            ],
          ),
        ),
      ),
    );
  }
}
