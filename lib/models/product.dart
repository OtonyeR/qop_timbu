//Product model
class Product {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final int? currentPrice;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.currentPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: (json['categories'] != null && json['categories'].isNotEmpty)
          ? json['categories'][0]['name']
          : 'Unknown',
      imageUrl: (json['photos'] != null && json['photos'].isNotEmpty)
          ? 'https://api.timbu.cloud/images/${json['photos'][0]['url']}'
          : '',
      description: json['description'] ?? '',
      currentPrice: (json['current_price'] != null &&
              json['current_price'].isNotEmpty &&
              json['current_price'][0] != null)
          ? json['current_price'][0]['NGN'][0].toInt()
          : null,
    );
  }
}

final List productsInBag = [];
