import 'package:fit_bowl_2/data/modeles/sale_model.dart';

import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.id,
    required super.userId,
    required super.salesIds,
    required super.cartTotal,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      userId: json['userId'],
      salesIds: (json['salesIds'] as List)
          .map((saleJson) => SaleModel.fromJson(saleJson))
          .toList(),
      cartTotal: json['cartTotal'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'salesIds': salesIds.map((sale) => (sale).toJson()).toList(),
      'cartTotal': cartTotal,
    };
  }
}
