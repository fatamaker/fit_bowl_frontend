class Supplement {
  final String id;
  final String name;
  final double price;
  final double? calories;

  Supplement({
    required this.id,
    required this.name,
    required this.price,
    this.calories,
  });
}
