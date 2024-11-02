import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: "Classic Cheese Burger",
      description:
          "A juicy beef patty with melted cheddar , lettuce , tomato and a hint of onion and pickle",
      imagePath: "lib/images/burgers/cheese_burger.jpeg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99),
      ],
    ),

    Food(
      name: "ALoha Burger",
      description:
          "Taste paradise with our Aloha Burger! Juicy beef, grilled pineapple, crispy bacon, teriyaki sauce, and melted cheese combine for a savory-sweet sensation!",
      imagePath: "lib/images/burgers/aloha_burger.png",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Crispy onion straws", price: 0.99),
        Addon(name: "Jalapeno slices", price: 1.99),
        Addon(name: "Fried Egg", price: 2.99),
      ],
    ),

    Food(
      name: "BBQ Burger",
      description:
          "Get ready for BBQ bliss with our BBQ Burger! Juicy patty, smoky barbecue sauce, crispy bacon, cheddar cheese, and onion rings on a toasted bun. It's BBQ perfection!",
      imagePath: "lib/images/burgers/bbq_burger.jpeg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Avocado Slices", price: 0.99),
        Addon(name: "Grilled Pineapple", price: 1.99),
        Addon(name: "Crispy Onion Rings", price: 2.99),
      ],
    ),

    Food(
      name: "Bluemoon Burger",
      description:
          "Introducing our Blue Moon Burger: A juicy patty topped with tangy blue cheese, crispy bacon, caramelized onions, and fresh lettuce on a toasted bun. A flavor explosion in every bite!",
      imagePath: "lib/images/burgers/bluemoon_burger.jpeg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Sweet Potato Fries", price: 0.99),
        Addon(name: "Sautéed Mushrooms", price: 1.99),
        Addon(name: "Garlic Aioli", price: 2.99),
      ],
    ),

    Food(
      name: "Veggies Burger",
      description:
          "Enjoy our Veggie Burger, a delicious plant-based option! Made with a flavorful veggie patty, topped with crisp lettuce, juicy tomato slices, creamy avocado, and zesty pickles, all served on a toasted bun. A satisfying choice for veggie lovers!",
      imagePath: "lib/images/burgers/vege_burger.jpeg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Guacamole", price: 0.99),
        Addon(name: "Roasted Red Peppers", price: 1.99),
        Addon(name: "Sriracha Mayo", price: 2.99),
      ],
    ),

    // salads
    Food(
      name: "Asian Sesame Salad",
      description:
          "Enjoy our Asian Sesame Salad: crisp greens, cabbage, carrots, sesame dressing, sesame seeds, and crunchy wonton strips.",
      imagePath: "lib/images/salad/asiansesame_salad.jpeg",
      price: 0.99,
      category: FoodCategory.salad,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 0.99),
        Addon(name: "Edamame", price: 1.99),
        Addon(name: "Mandarin Orange Segments", price: 2.99),
      ],
    ),

    Food(
      name: "Caesar Salad",
      description:
          "Enjoy our classic Caesar Salad! Crisp romaine lettuce, creamy Caesar dressing, Parmesan cheese, and crunchy croutons. A timeless favorite!",
      imagePath: "lib/images/salad/caesar_salad.jpeg",
      price: 0.99,
      category: FoodCategory.salad,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 0.99),
        Addon(name: "Bacon Bits", price: 1.99),
        Addon(name: "Avocado Slices", price: 2.99),
      ],
    ),

    Food(
      name: "Greek Salad",
      description:
          "Savor our Greek Salad: Fresh lettuce, tomatoes, cucumbers, olives, feta cheese, and Greek dressing. Mediterranean perfection!",
      imagePath: "lib/images/salad/greek_salad.jpg",
      price: 0.99,
      category: FoodCategory.salad,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 0.99),
        Addon(name: "Pepperoncini Peppers", price: 1.99),
        Addon(name: "Red Bell Peppers", price: 2.99),
      ],
    ),

    Food(
      name: "Quinioa Salad",
      description:
          "Try our Quinoa Salad: Nutrient-packed quinoa with bell peppers, cucumbers, cherry tomatoes, avocado, and toasted almonds, tossed in a zesty vinaigrette.",
      imagePath: "lib/images/salad/quinioa_salad.jpeg",
      price: 0.99,
      category: FoodCategory.salad,
      availableAddons: [
        Addon(name: "Grilled Tofu", price: 0.99),
        Addon(name: "Dried Cranberries:", price: 1.99),
        Addon(name: "Crumbled Feta Cheese", price: 2.99),
      ],
    ),

    Food(
      name: "Southwest Salad",
      description:
          "Enjoy our Southwest Salad: Crisp lettuce, black beans, corn, tomatoes, avocado, and tortilla strips with zesty Southwest dressing.",
      imagePath: "lib/images/salad/southwest_salad.jpg",
      price: 0.99,
      category: FoodCategory.salad,
      availableAddons: [
        Addon(name: "Grilled Tofu", price: 0.99),
        Addon(name: "Dried Cranberries:", price: 1.99),
        Addon(name: "Crumbled Feta Cheese", price: 2.99),
      ],
    ),

    // sides

    Food(
      name: "Garlic Bread",
      description:
          "Savor our Garlic Bread: Toasted slices of bread with garlic butter. A classic side dish!",
      imagePath: "lib/images/sides/garlic_bread_side.png",
      price: 0.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Parmesan Cheese", price: 0.99),
        Addon(name: "Fresh Herbs", price: 1.99),
        Addon(name: "Red Pepper Flakes", price: 2.99),
      ],
    ),

    Food(
      name: "Loaded Fries",
      description:
          "Savor our Loaded Fries: Crispy fries topped with melted cheese, bacon, sour cream, and green onions. Pure indulgence!",
      imagePath: "lib/images/sides/loadedfire_side.png",
      price: 0.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Jalapeños", price: 0.99),
        Addon(name: "Guacamole", price: 1.99),
        Addon(name: "Ranch Dressing", price: 2.99),
      ],
    ),

    Food(
      name: "Mac Side",
      description:
          "Try our Mac and Cheese Cake: Creamy macaroni and cheese baked to perfection for a crispy, cheesy delight!",
      imagePath: "lib/images/sides/mac_side.jpeg",
      price: 0.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Bacon Bits", price: 0.99),
        Addon(name: "Jalapeños", price: 1.99),
        Addon(name: "Bread Crumbs", price: 2.99),
      ],
    ),

    Food(
      name: "Onion Rings",
      description:
          "Savor our Onion Rings: Crispy, golden slices of sweet onions. A classic favorite!",
      imagePath: "lib/images/sides/onion_rings_side.jpeg",
      price: 0.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Spicy Dipping Sauce", price: 0.99),
        Addon(name: "Ranch Dressing", price: 1.99),
        Addon(name: "Garlic Aioli", price: 2.99),
      ],
    ),

    Food(
      name: "Sweet Potato",
      description:
          "Savor our Sweet Potatoes: Tender and flavorful, roasted to perfection for a delightful balance of sweetness and savory goodness.",
      imagePath: "lib/images/sides/sweet_potato_side.jpeg",
      price: 0.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Cinnamon Sugar", price: 0.99),
        Addon(name: "Maple Glaze", price: 1.99),
        Addon(name: "Marshmallows", price: 2.99),
      ],
    ),

    // desserts
    Food(
      name: "Apple Pie",
      description:
          "Enjoy our Apple Pie: Tender cinnamon-spiced apples in a flaky crust. A classic dessert favorite!",
      imagePath: "lib/images/desserts/apple_pie.jpeg",
      price: 0.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Vanilla Ice Cream", price: 0.99),
        Addon(name: "Caramel Sauce", price: 1.99),
        Addon(name: "Whipped Cream", price: 2.99),
      ],
    ),

    Food(
      name: "Cheese Cake",
      description:
          "Savor our Cheesecake: Creamy filling on a graham cracker crust. A delightful dessert!",
      imagePath: "lib/images/desserts/cheese_cake.jpeg",
      price: 0.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Fruit Compote", price: 0.99),
        Addon(name: "Chocolate Ganache", price: 1.99),
        Addon(name: "Whipped Cream", price: 2.99),
      ],
    ),

    Food(
      name: "Chocolate Cake",
      description:
          "Savor our Chocolate Cake: Moist layers of rich chocolate cake with indulgent chocolate ganache and creamy frosting. Pure chocolate bliss!",
      imagePath: "lib/images/desserts/choco_cake.jpg",
      price: 0.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Fresh Berries", price: 0.99),
        Addon(name: "Vanilla Ice Cream", price: 1.99),
        Addon(name: "Chocolate Shavings", price: 2.99),
      ],
    ),

    Food(
      name: "Creme Brulee",
      description:
          "Savor our Crème Brûlée: Silky custard with caramelized sugar crust. A classic indulgence!",
      imagePath: "lib/images/desserts/creme_desserts.jpeg",
      price: 0.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Fresh Berries", price: 0.99),
        Addon(name: "Mint Garnish", price: 1.99),
        Addon(name: "Shortbread Cookies", price: 2.99),
      ],
    ),

    Food(
      name: "Tiramisu Cake",
      description:
          "Savor our Tiramisu Cake: Espresso-soaked sponge cake layered with creamy mascarpone, dusted with cocoa. A decadent delight!",
      imagePath: "lib/images/desserts/tiramisu_cake.jpeg",
      price: 0.99,
      category: FoodCategory.deserts,
      availableAddons: [
        Addon(name: "Chocolate Shavings", price: 0.99),
        Addon(name: "Amaretto Syrup", price: 1.99),
        Addon(name: "Espresso Beans", price: 2.99),
      ],
    ),

    // drinks

    Food(
      name: "Cocktail",
      description:
          "Try our signature cocktail: A perfectly balanced blend of premium spirits and handcrafted ingredients, served chilled for an unforgettable drinking experience.",
      imagePath: "lib/images/drinks/cocktail_drink.jpg",
      price: 0.99,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Fruit Garnish", price: 0.99),
        Addon(name: "Herb Infusion", price: 1.99),
        Addon(name: "Sugar Rim", price: 2.99),
      ],
    ),

    Food(
      name: "COLA SOFT DRINK",
      description:
          "Enjoy our Cola Soft Drink: Classic carbonated refreshment with a hint of caffeine. Perfect any time!",
      imagePath: "lib/images/drinks/cola_drink.jpg",
      price: 0.99,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Lemon or Lime Wedge", price: 0.99),
        Addon(name: "Ice Cubes", price: 1.99),
        Addon(name: "Vanilla Syrup", price: 2.99),
      ],
    ),

    Food(
      name: "COFFEE",
      description:
          "Enjoy our freshly brewed coffee: Rich, robust, and satisfying. The perfect pick-me-up anytime.",
      imagePath: "lib/images/drinks/coffee_drink.jpeg",
      price: 0.99,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Flavored Syrups", price: 0.99),
        Addon(name: "Whipped Cream", price: 1.99),
        Addon(name: "Cinnamon or Cocoa Powder", price: 2.99),
      ],
    ),

    Food(
      name: "Iced Tea",
      description:
          "Sip on our refreshing Iced Tea: Chilled, brewed to perfection, and served over ice. Crisp and revitalizing, with a hint of sweetness. The perfect way to stay cool.",
      imagePath: "lib/images/drinks/Iced_tea_drink.jpeg",
      price: 0.99,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Fresh Mint Leaves", price: 0.99),
        Addon(name: "Sliced Citrus", price: 1.99),
        Addon(name: "Sweetener", price: 2.99),
      ],
    ),

    Food(
      name: "Lemon Soda",
      description:
          "Enjoy our Lemon Soda: Sparkling water infused with tangy lemon flavor. Refreshing and invigorating!",
      imagePath: "lib/images/drinks/lemon_drink.jpg",
      price: 0.99,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Mint Leaves", price: 0.99),
        Addon(name: "Lemon Wedge", price: 1.99),
        Addon(name: "Simple Syrup", price: 2.99),
      ],
    ),
  ];

  // user cart
  final List<CartItem> _cart = [];

  // Delivery Address which the user can change/update
  String _deliveryAdress = "Enter your Address here.";
  /*

    G E T T E R S 

  */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAdress;

  /*

    O P E R A T I O N S  

  */

  // add to the cart
  void addToCart(Food food, List<Addon> selectedAddon) {
    // see if there is a cart item arleady with same food and selected Add on
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;
      // check if the selected Addons are the same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddon, selectedAddon);

      return isSameFood && isSameAddons;
    });

    // if the item already exists , increase the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // otherwise , add new cart item to the cart
    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddon: selectedAddon,
        ),
      );
    }
    notifyListeners();
  }

  // remove from the cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price from cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddon) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // get total number of items in the cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear the cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateDeliveryAddress(String newAddress) {
    _deliveryAdress = newAddress;
    notifyListeners();
  }
  /*

    H E L P E R S  

  */

  // generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here is your receipt.");
    receipt.writeln();

    // format the date to include upto seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} -${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddon.isNotEmpty) {
        receipt
            .writeln("   Add-ons : ${_formatAddons(cartItem.selectedAddon)}");
      }
      receipt.writeln();
    }
    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items : ${getTotalItemCount()} ");
    receipt.writeln("Total Price : ${_formatPrice(getTotalPrice())} ");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  // format list of addons itno a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
