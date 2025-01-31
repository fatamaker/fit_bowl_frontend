import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/presentation/controllers/order_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late OrderController _orderController;
  late ProductController _productController;
  late String currentUserId;
  bool isLoading = true;
  String errorMessage = '';
  final Map<String, Product?> productCache = {}; // Cache for products

  @override
  void initState() {
    super.initState();
    _orderController = Get.find();
    _productController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;
    _fetchUserOrders();
  }

  Future<void> _fetchUserOrders() async {
    try {
      setState(() => isLoading = true);
      final success = await _orderController.getUserOrders(currentUserId);
      setState(() => isLoading = false);
      if (!success) {
        errorMessage = 'Failed to load orders';
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading orders: $error';
      });
    }
  }

  Future<Product?> _fetchProduct(String productId) async {
    // Return the product from cache if already fetched
    if (productCache.containsKey(productId)) {
      return productCache[productId];
    }

    // Otherwise, fetch it and cache it
    final success = await _productController.getProductById(productId);
    if (success) {
      productCache[productId] = _productController.selectedProduct;
      return _productController.selectedProduct;
    } else {
      return null;
    }
  }

  // Show the dialog with order details
  void _showOrderDetailsDialog(Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Order Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: order.salesIds.length,
              itemBuilder: (context, index) {
                final sale = order.salesIds[index];
                return FutureBuilder<Product?>(
                  future: _fetchProduct(sale.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final product = snapshot.data ??
                        Product(name: 'Unknown', id: '', image: '');

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.image,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product: ${product.name}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Price: \$${sale.totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: \$${order.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order History",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: const TextStyle(fontSize: 18)))
              : _orderController.userOrders.isEmpty
                  ? const Center(
                      child: Text('No orders yet!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: _orderController.userOrders.length,
                            itemBuilder: (context, index) {
                              final order = _orderController.userOrders[index];
                              return GestureDetector(
                                onTap: () {
                                  _showOrderDetailsDialog(
                                      order); // Show the dialog when tapped
                                },
                                child: OrderHistoryCard(
                                  orderId: "Order ${index + 1}",
                                  quantity: order.salesIds.length,
                                  totalPrice: order.totalAmount,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final String orderId;
  final int quantity;
  final double totalPrice;

  const OrderHistoryCard({
    super.key,
    required this.orderId,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3F3F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.receipt_long, // Order icon
              size: 30,
              color: const Color.fromARGB(255, 24, 89, 35),
            ),
            const SizedBox(width: 16),
            // Displaying Order ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Displaying Order Number (e.g. "Order 1")
                  Text(
                    orderId,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),

                  // Displaying Quantity
                  Text(
                    'Quantity: $quantity',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4.0),

                  // Displaying Total Price
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            // Cart Icon
          ],
        ),
      ),
    );
  }
}
