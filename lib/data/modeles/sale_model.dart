import '../../domain/entities/sale.dart';

class SaleModel extends Sale {
  SaleModel({
    required super.id,
    required super.productId,
    required super.userId,
    required super.quantity,
    required super.totalPrice,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['_id'],
      productId: json['productId'],
      userId: json['userId'],
      quantity: json['quantity'],
      totalPrice: json['totalprice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'quantity': quantity,
      'totalprice': totalPrice,
    };
  }
}
