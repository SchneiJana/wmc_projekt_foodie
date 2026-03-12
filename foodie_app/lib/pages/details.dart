import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie_app/models/food.dart';

class DetailsPage extends StatefulWidget {
  final Food food;

  const DetailsPage({super.key, required this.food});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _quantity = 1;

  Future<void> _addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];
    
    Map<String, dynamic> cartItem = {
      'food': widget.food.toJson(),
      'quantity': _quantity,
      'totalPrice': widget.food.price * _quantity,
    };
    
    cartItems.add(jsonEncode(cartItem));
    await prefs.setStringList('cart', cartItems);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.food.name} ($_quantity ${widget.food.unit}) zum Warenkorb hinzugefügt!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Placeholder
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.image_outlined, size: 100, color: Colors.black54),
                      ),
                      const SizedBox(height: 24),
                      // Title and Shopname
                      Text(
                        widget.food.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.food.shopname,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),
                      // Price and Quantity Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "€${widget.food.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.0),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "/${widget.food.unit}",
                                style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          // Number Picker
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                                icon: const Icon(Icons.remove, size: 20),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "$_quantity ${widget.food.unit}",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                onPressed: () {
                                  setState(() => _quantity++);
                                },
                                icon: const Icon(Icons.add, size: 20),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Description
                      Text(
                        widget.food.description,
                        style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _addToCart,
                  icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                  label: const Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
