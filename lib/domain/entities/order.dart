import 'package:fit_bowl_2/data/modeles/sale_model.dart';

class Order {
  final String id;
  final String userId;
  final List<SaleModel> salesIds;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String payment;

  Order({
    required this.id,
    required this.userId,
    required this.salesIds,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.payment,
  });
}
