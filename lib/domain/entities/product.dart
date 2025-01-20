class Product {
  final String id;
  final String name;
  final String? image;
  final String? model3d;
  final String reference;
  final String? description;
  final String category;
  final List<String> suppIds;
  final Map<String, SizeInfo> sizes;

  Product({
    required this.id,
    required this.name,
    this.image,
    this.model3d,
    required this.reference,
    this.description,
    required this.category,
    required this.suppIds,
    required this.sizes,
  });
}

class SizeInfo {
  final double price;
  final int? calories;

  SizeInfo({
    required this.price,
    this.calories,
  });
}
