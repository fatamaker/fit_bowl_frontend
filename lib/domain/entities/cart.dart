import 'package:fit_bowl_2/data/modeles/sale_model.dart';

class Cart {
  final String id;
  final String userId;
  final List<SaleModel> salesIds;
  final double cartTotal;

  Cart({
    required this.id,
    required this.userId,
    required this.salesIds,
    required this.cartTotal,
  });
}
