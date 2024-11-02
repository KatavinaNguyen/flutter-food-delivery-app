import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String customerId;
  final List<Map<String, dynamic>> items; // List of items with their details
  final double totalPrice;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalPrice,
    required this.createdAt,
  });

  // Convert an Order object into a map to send to Firestore
  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'items': items,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create an Order object from a Firestore document
  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc.id,
      customerId: data['customer_id'] ?? '',
      items: List<Map<String, dynamic>>.from(data['items'] ?? []),
      totalPrice: data['total_price']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(
          data['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
