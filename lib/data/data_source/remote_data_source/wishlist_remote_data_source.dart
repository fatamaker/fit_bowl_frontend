import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/wishlist_model.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> createWishlist(Map<String, dynamic> wishlistData);
  Future<WishlistModel?> getWishlistByUserId(String userId);
  Future<WishlistModel> updateWishlist(
      String wishlistId, List<String> products);
  Future<WishlistModel> removeProductFromWishlist(
      String userId, String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  WishlistRemoteDataSourceImpl();

  @override
  Future<WishlistModel> createWishlist(
      Map<String, dynamic> wishlistData) async {
    try {
      final uri = Uri.parse(APIConst.createWishlist);
      final response = await http.post(
        uri,
        body: json.encode(wishlistData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return WishlistModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<WishlistModel?> getWishlistByUserId(String userId) async {
    try {
      final uri =
          Uri.parse(APIConst.getWishlist.replaceFirst(':userId', userId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return WishlistModel.fromJson(body);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<WishlistModel> updateWishlist(
      String wishlistId, List<String> products) async {
    try {
      final uri = Uri.parse(APIConst.updateWishlist);
      final response = await http.put(
        uri,
        body: json.encode({
          'id': wishlistId,
          'products': products,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return WishlistModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<WishlistModel> removeProductFromWishlist(
      String userId, String productId) async {
    try {
      final uri = Uri.parse(APIConst.removeproductWishlist);
      final response = await http.post(
        uri,
        body: json.encode({'userId': userId, 'productId': productId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return WishlistModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
