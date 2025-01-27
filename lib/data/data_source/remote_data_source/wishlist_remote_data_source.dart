import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/wishlist_model.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  Future<void> createWishList({required String userId});
  Future<WishlistModel?> getWishlistByUserId(String userId);
  Future<WishlistModel> updateWishlist(
      String wishlistId, List<String> products);
  Future<WishlistModel> removeProductFromWishlist(
      String userId, String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  WishlistRemoteDataSourceImpl();
  @override
  Future<void> createWishList({required String userId}) async {
    try {
      final url = Uri.parse(APIConst.createWishList);
      final body = jsonEncode({'userId': userId, 'productIds': []});
      print(body);
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to create wishlist");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WishlistModel?> getWishlistByUserId(String userId) async {
    try {
      // Add the userId as a query parameter
      final uri = Uri.parse('${APIConst.getWishlist}?userId=$userId');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        final body = json.decode(response.body);
        return WishlistModel.fromJson(body);
      } else if (response.statusCode == 404) {
        return null; // No wishlist found
      } else {
        throw ServerException(); // Handle other errors
      }
    } catch (e) {
      throw ServerException(); // Handle network or other issues
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
      } else if (response.statusCode == 400) {
        // Handle validation error (e.g., missing fields or invalid input)
        final body = json.decode(response.body);
        throw Exception(body['message'] ?? 'Bad Request');
      } else if (response.statusCode == 404) {
        // Handle case when wishlist is not found
        throw Exception('Wishlist not found');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(); // Customize this exception if needed
    }
  }

  @override
  Future<WishlistModel> removeProductFromWishlist(
      String userId, String productId) async {
    try {
      final uri = Uri.parse(
          '${APIConst.removeproductWishlist}?userId=$userId&productId=$productId');
      final response = await http.delete(
        uri,
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
