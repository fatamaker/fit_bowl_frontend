import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/orderusecase/get_orderbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/orderusecase/get_user_orders_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/orderusecase/place_order_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/orderusecase/update_order_usecase.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';

class OrderController extends GetxController {
  List<Order> userOrders = [];
  Order? currentOrder;
  bool isLoading = false;
  String errorMessage = '';

  Future<bool> placeOrder(String userId) async {
    isLoading = true;
    update();

    final res = await PlaceOrderUseCase(sl())(userId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to place order';
        update();
        return false;
      },
      (order) {
        currentOrder = order;
        errorMessage = '';
        update();
        return true;
      },
    );
  }

  Future<bool> getUserOrders(String userId) async {
    isLoading = true;
    update();

    final res = await GetUserOrdersUseCase(sl())(userId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to load orders';
        update();
        return false;
      },
      (orders) {
        userOrders = orders;
        errorMessage = '';
        update();
        return true;
      },
    );
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    isLoading = true;
    update();

    final res = await UpdateOrderStatusUseCase(sl())(orderId, status);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = failure is ServerException
            ? failure.message ?? 'Failed to update order status'
            : 'Failed to update order status';
        update();
        return false;
      },
      (order) {
        currentOrder = order;
        errorMessage = '';
        update();
        return true;
      },
    );
  }

  Future<bool> getOrderById(String orderId) async {
    isLoading = true;
    update();

    final res = await GetOrderByIdUseCase(sl())(orderId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to fetch order';
        update();
        return false;
      },
      (order) {
        currentOrder = order;
        errorMessage = '';
        update();
        return true;
      },
    );
  }

  void resetOrderState() {
    currentOrder = null;
    userOrders = [];
    errorMessage = '';
    update();
  }
}
