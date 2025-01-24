import 'dart:convert';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/supplement_model.dart';
import 'package:http/http.dart' as http;

abstract class SupplementRemoteDataSource {
  Future<SupplementModel> getSupplementById(String supplementId);
}

class SupplementRemoteDataSourceImpl implements SupplementRemoteDataSource {
  SupplementRemoteDataSourceImpl();

  @override
  Future<SupplementModel> getSupplementById(String supplementId) async {
    try {
      final uri = Uri.parse('${APIConst.oneSupplement}/$supplementId');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return SupplementModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
