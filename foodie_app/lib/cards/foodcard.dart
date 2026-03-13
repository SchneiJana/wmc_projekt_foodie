import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final double price;
  final String unit;
  final String? imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onCartTap;

  const FoodCard({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    this.imagePath,
    this.onTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath!.trim(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_outlined,
                              size: 80,
                              color: Colors.black54,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.image_outlined,
                        size: 80,
                        color: Colors.black54,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 14)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                        text: "€",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: price % 1 == 0
                            ? price.toInt().toString()
                            : price.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: " / $unit",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
