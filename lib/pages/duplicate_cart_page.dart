import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_car_tile.dart';
import 'package:food_delivery_app/models/cart_item.dart'; // Ensure this import is present

class DuplicateCartPage extends StatelessWidget {
  final double totalPrice;
  final List<CartItem> cartItems; // Ensure this type matches your definition

  const DuplicateCartPage({
    Key? key,
    required this.totalPrice,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Duplicate Cart"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("Cart is empty..."))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return MyCartTile(cartItem: cartItem);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Price:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              text: "Go to checkout",
              onTap: totalPrice > 0
                  ? () {
                      // Implement checkout functionality here
                    }
                  : null, // Disable the button if totalPrice is 0
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
