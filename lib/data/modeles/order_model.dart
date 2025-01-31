import 'package:fit_bowl_2/data/modeles/sale_model.dart';

import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.userId,
    required super.salesIds,
    required super.totalAmount,
    required super.status,
    required super.deliveryAddress,
    required super.payment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      salesIds: (json['salesID'] as List<dynamic>?)
              ?.map((sale) => SaleModel.fromJson(sale))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      payment: json['payment'] ?? 'Unknown',
      deliveryAddress: json['deliveryAddress'] ?? 'No address provided',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'salesID': salesIds,
      'totalAmount': totalAmount,
      'status': status,
      'deliveryAddress': deliveryAddress,
      'payment': payment,
    };
  }
}
