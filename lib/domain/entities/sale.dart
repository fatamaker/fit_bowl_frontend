class Sale {
  final String id;
  final String productId;
  final String userId;
  final int quantity;
  final double totalPrice;
  final double totalCalories;
  final List<String> supplements;

  Sale({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.totalPrice,
    required this.totalCalories,
    required this.supplements,
  });
}
