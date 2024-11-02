import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/order.dart'
    as app_models; // Prefix for your Order model

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch order history for a given customer ID
  Future<List<app_models.Order>> getOrderHistory(String customerId) async {
    try {
      // Fetch orders where 'customer_id' matches the provided customerId
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('customer_id', isEqualTo: customerId)
          .orderBy('created_at', descending: true) // Optional: order by date
          .get();

      // Map documents to Order model
      return snapshot.docs.map((doc) {
        return app_models.Order.fromFirestore(doc); // Use the prefix here
      }).toList();
    } catch (e) {
      print("Error fetching order history: $e");
      return [];
    }
  }
}
