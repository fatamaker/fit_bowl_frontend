import '../../domain/entities/wishlist.dart';

class WishlistModel extends Wishlist {
  WishlistModel({
    required super.id,
    required super.userId,
    required super.productIds,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'],
      userId: json['userId'],
      productIds: List<String>.from(json['productId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productIds,
    };
  }
}
