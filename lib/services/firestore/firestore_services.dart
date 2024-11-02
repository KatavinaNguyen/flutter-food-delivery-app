import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create or update a user document in Firestore
  Future<void> createUserDocument(String userId, String email) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'email': email,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print("Error creating user document: $e");
      throw Exception('Failed to create user document.');
    }
  }

  // Retrieve user document from Firestore
  Future<Map<String, dynamic>?> getUserDocument(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error retrieving user document: $e");
      throw Exception('Failed to retrieve user document.');
    }
  }
}
