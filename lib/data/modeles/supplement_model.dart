import '../../domain/entities/supplement.dart';

class SupplementModel extends Supplement {
  SupplementModel({
    required super.id,
    required super.name,
    required super.price,
    super.calories,
  });

  factory SupplementModel.fromJson(Map<String, dynamic> json) {
    return SupplementModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      calories: json['calories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'calories': calories,
    };
  }
}
