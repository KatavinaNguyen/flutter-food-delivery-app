import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as custom_badge; // Renamed import
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_car_tile.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/pages/paryment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? parentKey, Key? childKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // Cart
        final userCart = restaurant.cart;

        // Calculate total number of items including quantities
        int totalItemCount = restaurant.getTotalItemCount();

        // Calculate total price
        double totalPrice = userCart.fold(
          0,
          (sum, item) => sum + (item.totalPrice * item.quantity),
        );

        // Scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // Badge for total item count
              custom_badge.Badge(
                position: custom_badge.BadgePosition.topEnd(top: 0, end: 3),
                badgeContent: Text(
                  '$totalItemCount',
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Navigate to the cart page or perform other actions
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                ),
              ),
              // Clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // Yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              // List of cart items
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text("Cart is empty..."),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // Get individual cart item
                                final cartItem = userCart[index];

                                // Return cart tile UI
                                return MyCartTile(cartItem: cartItem);
                              },
                            ),
                          ),
                  ],
                ),
              ),
              // Display total price
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
              // Button to pay
              MyButton(
                text: "Go to checkout",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
