class Food {
  final int id;
  final String name;
  final String description;
  final String shopname;
  final double price;
  final String unit;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.shopname,
    required this.price,
    required this.unit,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as int,
      name: json['name'],
      description: json['description'],
      shopname: json['shopname'],
      price: json['price'] as double,
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'shopname': shopname,
    'price': price,
    'unit': unit,
  };
}
