import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/cart_model.dart';

import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<CartModel> addSaleToCart(String userId, String saleId);
  Future<CartModel?> getCartByUser(String userId);
  Future<CartModel> removeSaleFromCart(String userId, String saleId);
  Future<CartModel> clearCart(String userId);
  Future<CartModel> createCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  CartRemoteDataSourceImpl();

  @override
  Future<CartModel> createCart(String userId) async {
    try {
      final url = Uri.parse(APIConst.createCart);
      final body = json.encode({
        'userId': userId,
      });

      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return CartModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create cart');
      }
    } catch (e) {
      throw Exception('Error creating cart: $e');
    }
  }

  @override
  Future<CartModel> addSaleToCart(String userId, String saleId) async {
    try {
      final uri = Uri.parse(APIConst.addsaleCart);
      final response = await http.post(
        uri,
        body: json.encode({
          'userId': userId,
          'salesIds': saleId,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return CartModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw SaleNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CartModel?> getCartByUser(String userId) async {
    try {
      final uri = Uri.parse(APIConst.userCart.replaceFirst(':userId', userId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        final cart = CartModel.fromJson(body);

        return cart;
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
  Future<CartModel> removeSaleFromCart(String userId, String saleId) async {
    try {
      final uri = Uri.parse(APIConst.removesaleCart);
      print(uri);
      final response = await http.post(
        uri,
        body: json.encode({
          'userId': userId,
          'salesIds': saleId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return CartModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw SaleNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CartModel> clearCart(String userId) async {
    try {
      final uri = Uri.parse(APIConst.clearCart.replaceFirst(':userId', userId));
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return CartModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
