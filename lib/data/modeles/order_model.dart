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
      id: json['_id'],
      userId: json['userId'],
      salesIds: List<String>.from(json['salesID']),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      deliveryAddress: json['deliveryAdress'],
      payment: json['payment'],
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
