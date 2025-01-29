import '../../domain/entities/sale.dart';

class SaleModel extends Sale {
  SaleModel({
    required super.id,
    required super.productId,
    required super.userId,
    required super.quantity,
    required super.totalPrice,
    required super.totalCalories,
    required super.supplements, // Add supplements parameter
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['_id'],
      productId: json['productId'],
      userId: json['userId'],
      quantity: json['quantity'],
      totalPrice: json['totalprice'].toDouble(),
      totalCalories: json['totalCalories'].toDouble(),
      supplements: List<String>.from(
          json['supplements'] ?? []), // Parse supplements list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'quantity': quantity,
      'totalprice': totalPrice,
      'totalCalories': totalCalories,
      'supplements': supplements, // Include supplements in toJson
    };
  }
}
