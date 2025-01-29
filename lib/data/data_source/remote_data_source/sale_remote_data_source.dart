import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/sale_model.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/update_sale_usecase.dart';
import 'package:http/http.dart' as http;

abstract class SaleRemoteDataSource {
  Future<SaleModel> createSale(CreateSaleParams saleData);
  Future<List<SaleModel>> getAllSales();
  Future<SaleModel> getSaleById(String saleId);
  Future<SaleModel> updateSale(UpdateSaleParams params);
  Future<void> deleteSale(String saleId);
}

class SaleRemoteDataSourceImpl implements SaleRemoteDataSource {
  SaleRemoteDataSourceImpl();

  @override
  Future<SaleModel> createSale(CreateSaleParams saleData) async {
    try {
      final uri = Uri.parse(APIConst.createSale);
      print(uri);
      final response = await http.post(
        uri,
        body: json.encode(saleData.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      print(response);
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return SaleModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SaleModel>> getAllSales() async {
    try {
      final uri = Uri.parse(APIConst.allSales);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((sale) => SaleModel.fromJson(sale)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SaleModel> getSaleById(String saleId) async {
    try {
      final uri = Uri.parse(APIConst.oneSale.replaceFirst(':id', saleId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        print('Decoded response body: $body');

        // Parse the SaleModel and log its fields
        final sale = SaleModel.fromJson(body);
        print(
            'Parsed SaleModel: id = ${sale.id}, productId = ${sale.productId}, userId = ${sale.userId}');

        return sale;
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
  Future<SaleModel> updateSale(UpdateSaleParams params) async {
    try {
      // Convert UpdateSaleParams to Map<String, dynamic>
      final saleData = {
        'productId': params.productId,
        'userId': params.userId,
        'quantity': params.quantity,
        'supplements': params.supplements,
        'size': params.size,
      };

      // Use the saleId from UpdateSaleParams to create the URI
      final uri =
          Uri.parse(APIConst.updateSale.replaceFirst(':id', params.saleId));

      // Perform the PUT request with the sale data
      final response = await http.put(
        uri,
        body: json.encode(saleData),
        headers: {'Content-Type': 'application/json'},
      );

      // Check the response and return the sale model if successful
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return SaleModel.fromJson(body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteSale(String saleId) async {
    try {
      final uri = Uri.parse(APIConst.deleteSale.replaceFirst(':id', saleId));
      final response = await http.delete(uri);

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
