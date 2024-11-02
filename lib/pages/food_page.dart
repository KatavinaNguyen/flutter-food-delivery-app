import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;

  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Map<Addon, bool> selectedAddons;

  @override
  void initState() {
    super.initState();
    selectedAddons = {
      for (var addon in widget.food.availableAddons) addon: false
    };
  }

  void addToCart(Food food) {
    Navigator.pop(context);
    List<Addon> currentlySelectedAddons = _getSelectedAddons();
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  List<Addon> _getSelectedAddons() {
    return selectedAddons.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(widget.food.imagePath),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '\$${widget.food.discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (widget.food.discount != null)
                        Text(
                          'Original Price: \$${widget.food.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(widget.food.description),
                      const SizedBox(height: 10),
                      Divider(color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(height: 10),
                      _buildAddonsSection(),
                    ],
                  ),
                ),
                MyButton(
                  text: "Add to cart",
                  onTap: () => addToCart(widget.food),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add-ons",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: widget.food.availableAddons.length,
            itemBuilder: (context, index) {
              Addon addon = widget.food.availableAddons[index];
              return CheckboxListTile(
                title: Text(addon.name),
                subtitle: Text(
                  '\$${addon.price}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                value: selectedAddons[addon],
                onChanged: (bool? value) {
                  setState(() {
                    selectedAddons[addon] = value!;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
