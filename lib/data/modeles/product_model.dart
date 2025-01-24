import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    super.name,
    required super.image,
    super.model3d,
    super.reference,
    super.description,
    super.category,
    super.suppIds,
    super.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['_id'],
        name: json['name'],
        image: json['image'],
        model3d: json['model3d'],
        reference: json['reference'],
        description: json['description'],
        category: json['category'],
        suppIds:
            (json['SuppId'] as List<dynamic>).map((e) => e.toString()).toList(),
        sizes: ProductSizeModel.fromJson(json['sizes']));
  }
}

class ProductSizeModel extends ProductSize {
  ProductSizeModel({super.small, super.medium, super.large});

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) =>
      ProductSizeModel(
          small: SizeInfoModel.fromJson(json["small"]),
          medium: SizeInfoModel.fromJson(json["medium"]),
          large: SizeInfoModel.fromJson(json["large"]));
}

class SizeInfoModel extends SizeInfo {
  SizeInfoModel({required super.price, super.calories});

  factory SizeInfoModel.fromJson(Map<String, dynamic> json) =>
      SizeInfoModel(price: json["price"], calories: json["calories"]);
}
