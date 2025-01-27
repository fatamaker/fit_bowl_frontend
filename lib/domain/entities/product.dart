import 'package:fit_bowl_2/data/modeles/supplement_model.dart';

class Product {
  final String id;
  final String? name;
  final String image;
  final String? model3d;
  final String? reference;
  final String? description;
  final String? category;
  final List<SupplementModel>? suppId;
  final ProductSize? sizes;

  Product({
    required this.id,
    this.name,
    required this.image,
    this.model3d,
    this.reference,
    this.description,
    this.category,
    this.suppId,
    this.sizes,
  });
}

class ProductSize {
  final SizeInfo? small;
  final SizeInfo? medium;
  final SizeInfo? large;
  ProductSize({this.small, this.medium, this.large});
}

class SizeInfo {
  final double price;
  final int? calories;

  SizeInfo({
    required this.price,
    this.calories,
  });
}
