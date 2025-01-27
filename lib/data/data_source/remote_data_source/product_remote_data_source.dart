import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getSortedProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl();

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final uri = Uri.parse(APIConst.allProducts);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((product) => ProductModel.fromJson(product)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getSortedProducts() async {
    final uri = Uri.parse(APIConst.sortedProduct);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((product) => ProductModel.fromJson(product)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final uri = Uri.parse(APIConst.oneProduct.replaceFirst(':id', id));

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return ProductModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw ProductNotFoundException("Product not found");
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final uri = Uri.parse(
        APIConst.productbycategory.replaceFirst(':category', category));
    print("Fetching from URL: ${uri.toString()}");
    try {
      final response = await http.get(uri);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((product) => ProductModel.fromJson(product)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
