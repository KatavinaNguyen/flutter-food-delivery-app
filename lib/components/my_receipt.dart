import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 5),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add logo at the top
              Image.asset(
                'lib/images/logo/Yum_Yum_Logo.PNG',
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
              ),
              const SizedBox(height: 25),
              const Text("Thank you for your order!"),
              const SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(25),
                child: Consumer<Restaurant>(
                  builder: (context, restaurant, child) {
                    final receipt = restaurant.displayCartReceipt();
                    return Text(
                        receipt.isNotEmpty ? receipt : "Your cart is empty.");
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text("Estimated delivery time is: 4:10 PM"),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the home page
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
