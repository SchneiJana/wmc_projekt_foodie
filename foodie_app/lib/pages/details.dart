import 'package:flutter/material.dart';
import 'package:foodie_app/models/food.dart';

class DetailsPage extends StatelessWidget {
  final Food food;

  const DetailsPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image_outlined, size: 100, color: Colors.black54),
            const SizedBox(height: 20),
            Text(food.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(food.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text("€${food.price} / ${food.unit}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Shop: ${food.shopname}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
