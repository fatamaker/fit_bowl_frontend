import 'dart:convert';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getCategoryById(String categoryId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final uri = Uri.parse(APIConst.allCategories);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw ServerException(message: 'Failed to load categories');
      }
    } catch (e) {
      throw ServerException(message: 'Server error occurred');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      final uri =
          Uri.parse(APIConst.oneCategorie.replaceFirst(':id', categoryId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return CategoryModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw CategoryNotFoundException();
      } else {
        throw ServerException(message: 'Failed to fetch category');
      }
    } catch (e) {
      throw ServerException(message: 'Server error occurred');
    }
  }
}
