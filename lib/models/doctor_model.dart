import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String name;
  final List<dynamic> availableDates;

//<editor-fold desc="Data Methods">
  const DoctorModel({
    required this.id,
    required this.name,
    required this.availableDates,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          availableDates == other.availableDates);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ availableDates.hashCode;

  @override
  String toString() {
    return 'DoctorModel{ id: $id, name: $name, availableDates: $availableDates,}';
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    List<dynamic>? availableDates,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      availableDates: availableDates ?? this.availableDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'available_dates': this.availableDates,
    };
  }

  factory DoctorModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return DoctorModel(
      id: snapshot.id,
      name: data["name"],
      availableDates: data["avilable_dates"],
    );
  }

//</editor-fold>
}
