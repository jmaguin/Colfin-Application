class Purchase {
  int id;
  final String name;
  final double price;
  final String category;
  final DateTime createdAt;

  Purchase({
    this.id = 0,
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
    return 'Purchase{ID: $id, Name: $name, Price: $price, Category: $category, Created At: ${createdAt.hour}:${createdAt.minute}}';
  }
}
