import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/models/food.dart'; // Ensure this import is present
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  bool _isCvvFocused = false;

  @override
  void initState() {
    super.initState();
    // Optionally: Load cart data or initialize necessary data here
  }

  void _userTappedPay() {
    if (_formKey.currentState!.validate()) {
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Payment"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              _buildDialogRow("Card Number:", _cardNumber),
              _buildDialogRow("Expiry Date:", _expiryDate),
              _buildDialogRow("Card Holder Name:", _cardHolderName),
              _buildDialogRow("CVV:", _cvvCode),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the confirmation dialog
              _showReceiptDialog();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _showReceiptDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: const Text("Here is your receipt"),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'lib/images/logo/Yum_Yum_Logo.PNG',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thank you for your purchase!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(displayCartReceipt(), textAlign: TextAlign.left),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the receipt dialog
              Provider.of<Restaurant>(context, listen: false)
                  .clearCart(); // Clear cart after receipt confirmation

              // Navigate back to the home page
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Method to generate the receipt
  String displayCartReceipt() {
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    final receipt = StringBuffer();
    receipt.writeln();

    // Format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    // Retrieve the cart items and total price from the restaurant instance
    for (final cartItem in restaurant.cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddon.isNotEmpty) {
        receipt.writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddon)}");
      }
      receipt.writeln();
    }
    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${restaurant.getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(restaurant.getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: ${restaurant.deliveryAddress}");

    return receipt.toString();
  }

  // Updated _formatAddons to handle List<Addon>
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (\$${addon.price.toStringAsFixed(2)})")
        .join(', ');
  }

  // Example method for formatting price
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  Widget _buildDialogRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text("$title $value"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: _cardNumber,
              expiryDate: _expiryDate,
              cardHolderName: _cardHolderName,
              cvvCode: _cvvCode,
              showBackView: _isCvvFocused,
              onCreditCardWidgetChange: (creditCardBrand) {},
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CreditCardForm(
                formKey: _formKey,
                cardNumber: _cardNumber,
                expiryDate: _expiryDate,
                cardHolderName: _cardHolderName,
                cvvCode: _cvvCode,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    _cardNumber = data.cardNumber;
                    _expiryDate = data.expiryDate;
                    _cardHolderName = data.cardHolderName;
                    _cvvCode = data.cvvCode;
                    _isCvvFocused = data.isCvvFocused;
                  });
                },
                obscureCvv: true,
                obscureNumber: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyButton(
                text: "Pay Now",
                onTap: _userTappedPay,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
