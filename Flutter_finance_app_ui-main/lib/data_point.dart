class DataPoint {
  double price;
  String category;
  int createdAt;
  int time;

  DataPoint(
      {required this.price,
      required this.category,
      required this.createdAt,
      required this.time});

  // Convert Purchase into map
  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'category': category,
      'createdAt': createdAt,
      'time': time
    };
  }

  // Print info about purchase
  @override
  String toString() {
    return "Price: $price\nCategory: $category\nCreated At: $createdAt";
  }
}
