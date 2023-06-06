class Purchase {
  final int id;
  final String name;
  final double price;
  final String category;
  final int createdAt;
  final int? year;
  final int? month;
  final int? day;
  final String? weekday;

  const Purchase({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.year,
    required this.month,
    required this.day,
    required this.weekday,
  });

  // Convert Purchase into map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'createdAt': createdAt,
      'year': year,
      'month': month,
      'day': day,
      'weekday': weekday,
    };
  }

  // Print info about purchase
  @override
  String toString() {
    return "ID: $id\nName: $name\nPrice: $price\nCategory: $category\nCreated At: $createdAt";
  }

  // Overload == operator
  @override
  bool operator ==(Object other) {
    if (other is Purchase) {
      return id == other.id &&
          name == other.name &&
          price == other.price &&
          category == other.category &&
          createdAt == other.createdAt;
    }
    return false;
  }

  // Overload < operator
  @override
  bool operator <(Purchase other) {
    if (price > other.price) return false;
    return true;
  }

  // Overload > operator
  @override
  bool operator >(Purchase other) {
    if (price < other.price) return false;
    return true;
  }

  @override
  int get hashCode => super.hashCode;
}
