import 'package:food_delivery_app/models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddon;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
    required this.selectedAddon,
  });

  // G E T T E R S
  double get totalPrice {
    double addonsPrice =
        selectedAddon.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonsPrice) * quantity;
  }
}
