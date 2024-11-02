import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Customer object into a map to send to Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create a Customer object from a Firestore document
  factory Customer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Customer(
      id: doc.id,
      email: data['email'] ?? '',
      createdAt: DateTime.parse(
          data['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          data['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
