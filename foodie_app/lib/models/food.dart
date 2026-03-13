class Food {
  final int id;
  final String name;
  final String description;
  final String shopname;
  final double price;
  final String unit;
  final String? imagePath;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.shopname,
    required this.price,
    required this.unit,
    this.imagePath,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    final image = json['image'] as String?;
    return Food(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      shopname: json['shopname'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String? ?? '',
      imagePath: (image != null && image.isNotEmpty) ? 'assets/${image}' : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'shopname': shopname,
    'price': price,
    'unit': unit,
    'imagePath': imagePath,
  };
}
