class Purchase {
  final int id;
  final String name;
  final double price;
  final String category;
  final int createdAt;

  const Purchase({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
  });

  // Convert Purchase into map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'createdAt': createdAt,
    };
  }

  // Print info about purchase
  @override
  String toString() {
    return 'ID: $id\nName: $name\nPrice: $price\nCategory: $category\nCreated At: $createdAt';
  }
}
