// app/lib/models/food.dart

class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  final double? discount; // Optional discount
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
    this.discount,
  });

  double get discountedPrice =>
      discount != null ? price - (price * discount!) : price;
}

// Food Categories
enum FoodCategory {
  burgers,
  salad,
  sides,
  deserts,
  drinks,
}

// Food Add-ons
class Addon {
  final String name;
  final double price;

  Addon({required this.name, required this.price});
}
