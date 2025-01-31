import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';
import 'package:fit_bowl_2/data/modeles/order_model.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  Future<OrderModel> placeOrder(
      String userId, String deliveryAddress, String payment);
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> updateOrderStatus(String orderId, String status);
  Future<OrderModel> getOrderById(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl();

  @override
  Future<OrderModel> placeOrder(
      String userId, String deliveryAddress, String payment) async {
    try {
      final uri = Uri.parse(APIConst.placeOrder);
      final response = await http.post(
        uri,
        body: json.encode({
          'userId': userId,
          'deliveryAddress': deliveryAddress,
          'payment': payment
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final Map<String, dynamic> body = json.decode(response.body);
        print("Decoded Body: $body");
        return OrderModel.fromJson(body);
      } else if (response.statusCode == 400) {
        throw BadRequestException(message: 'Cart is empty or not found');
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("Error placing order: $e");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final uri = Uri.parse(APIConst.allOrders.replaceFirst(':userId', userId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((order) => OrderModel.fromJson(order)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<OrderModel> updateOrderStatus(String orderId, String status) async {
    try {
      final uri = Uri.parse(APIConst.updateOrderstatus);
      final response = await http.put(
        uri,
        body: json.encode({'orderId': orderId, 'status': status}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return OrderModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Order not found');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final uri = Uri.parse(APIConst.oneOrder.replaceFirst(':id', orderId));
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return OrderModel.fromJson(body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Order not found');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
