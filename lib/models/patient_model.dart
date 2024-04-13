import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String id;
  final String name;
  final String specifiedDate;
  final String surgeryType;
  final String doctor;

  PatientModel({
    required this.id,
    required this.name,
    required this.specifiedDate,
    required this.surgeryType,
    required this.doctor,
  });

  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return PatientModel(
      id: snapshot.id,
      name: data['name'],
      specifiedDate: data['specified_date'],
      surgeryType: data['surgery_type'],
      doctor: data['doctor'],
    );
  }

  @override
  String toString() {
    return 'PatientModel{id: $id, name: $name, specifiedDate: $specifiedDate, surgeryType: $surgeryType, doctor: $doctor}';
  }

  PatientModel copyWith({
    String? id,
    String? name,
    String? specifiedDate,
    String? surgeryType,
    String? doctor,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specifiedDate: specifiedDate ?? this.specifiedDate,
      surgeryType: surgeryType ?? this.surgeryType,
      doctor: doctor ?? this.doctor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specified_date': specifiedDate,
      'surgery_type': surgeryType,
      'doctor': doctor,
    };
  }
}
