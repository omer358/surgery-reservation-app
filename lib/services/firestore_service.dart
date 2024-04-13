import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new document to a collection
  Future<void> addData(Map<String, dynamic> data, String collectionName) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  // Get a single document by document ID from a collection
  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocumentById(
      String collectionName, String documentId) async {
    try {
      return await _firestore.collection(collectionName).doc(documentId).get();
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }

  // Method to get the doctor's data for a patient
  Future<Map<String, dynamic>?> getDoctorData(String doctorReferencePath) async {
    DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance.doc(doctorReferencePath).get();
    return doctorSnapshot.data() as Map<String, dynamic>;
  }

// Get all documents from a collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String collectionName) {
    try {
      return _firestore.collection(collectionName).snapshots();
    } catch (e) {
      print("Error getting collection: $e");
      return const Stream.empty();
    }
  }

  // Update an existing document in a collection
  Future<void> updateData(Map<String, dynamic> data, String documentId,
      String collectionName) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).update(data);
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  // Delete a document from a collection
  Future<void> deleteData(String documentId, String collectionName) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  // Get documents by a field attribute
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getDocumentsByField(
      String collectionName, String fieldName, dynamic attributeValue) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(collectionName)
          .where(fieldName, isEqualTo: attributeValue)
          .get();

      return snapshot.docs;
    } catch (e) {
      print("Error getting documents by field: $e");
      return [];
    }
  }
}
