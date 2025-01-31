// import 'package:fit_bowl_2/presentation/UI/secreens/order-status.dart';
// import 'package:fit_bowl_2/domain/entities/product.dart';
// import 'package:fit_bowl_2/domain/entities/sale.dart';
// import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
// import 'package:fit_bowl_2/presentation/controllers/cart_controller.dart';
// import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   String selectedPaymentMethod = "Credit Card";
//   final TextEditingController addressController = TextEditingController();

//   late CartController _cartController;
//   late ProductController _productController;
//   bool isLoading = true;
//   String errorMessage = '';
//   late String currentUserId;
//   List<Sale> cartSales = [];
//   Map<String, Product?> productCache = {}; // Cache for products

//   double subtotal = 0.0;
//   double deliveryFee = 5.0;

//   @override
//   void initState() {
//     super.initState();
//     _cartController = Get.find();
//     _productController = Get.find();
//     final AuthenticationController authenticationController = Get.find();
//     currentUserId = authenticationController.currentUser.id!;
//     _fetchCartData();
//   }

//   Future<void> _fetchCartData() async {
//     try {
//       setState(() => isLoading = true);
//       final cart = await _cartController.getCartByUserId(currentUserId);
//       if (cart != null) {
//         cartSales = cart.salesIds;
//         subtotal = cartSales.fold(0.0, (sum, sale) => sum + sale.totalPrice);
//       }
//       setState(() => isLoading = false);
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Failed to load cart data: $error';
//       });
//     }
//   }

//   Future<Product?> _fetchProduct(String productId) async {
//     if (productCache.containsKey(productId)) {
//       return productCache[productId]; // Return cached product
//     }

//     final success = await _productController.getProductById(productId);
//     if (success) {
//       productCache[productId] = _productController.selectedProduct;
//       return _productController.selectedProduct;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double total = subtotal + deliveryFee;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? Center(
//                   child:
//                       Text(errorMessage, style: const TextStyle(fontSize: 18)),
//                 )
//               : SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       _buildSectionTitle("🛍 Order Summary"),
//                       const SizedBox(height: 10),
//                       ...cartSales.map((sale) => FutureBuilder<Product?>(
//                             future: _fetchProduct(sale.productId),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }
//                               if (!snapshot.hasData || snapshot.data == null) {
//                                 return const Text(
//                                     'Product details unavailable');
//                               }
//                               final product = snapshot.data!;
//                               return _buildOrderItem(
//                                 product.image,
//                                 product.name!,
//                                 sale.quantity,
//                                 sale.totalPrice,
//                               );
//                             },
//                           )),
//                       const SizedBox(height: 40),
//                       _buildSectionTitle("📍 Delivery Address"),
//                       const SizedBox(height: 10),
//                       _buildAddressInput(),
//                       const SizedBox(height: 40),
//                       _buildSectionTitle("💳 Payment Method"),
//                       const SizedBox(height: 10),
//                       _buildPaymentMethod(),
//                       const SizedBox(height: 40),
//                       _buildSectionTitle("🏷 Order Total"),
//                       const SizedBox(height: 10),
//                       _buildTotalSection(subtotal, deliveryFee, total),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content:
//                                       Text("✅ Order Placed Successfully!")),
//                             );
//                             Get.to(() => OrderStatusScreen());
//                           },
//                           child: const Text("Confirm Order",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _buildOrderItem(
//       String imageUrl, String name, int quantity, double price) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(imageUrl,
//                   width: 60, height: 60, fit: BoxFit.cover),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(name,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//             Text("\$${(price * quantity).toStringAsFixed(2)}",
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressInput() {
//     return TextField(
//       controller: addressController,
//       decoration: InputDecoration(
//         hintText: "Enter your delivery address",
//         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//     );
//   }

//   Widget _buildPaymentMethod() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: DropdownButton<String>(
//           value: selectedPaymentMethod,
//           isExpanded: true,
//           underline: const SizedBox(),
//           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
//             return DropdownMenuItem(
//                 value: method,
//                 child: Text(method, style: const TextStyle(fontSize: 16)));
//           }).toList(),
//           onChanged: (value) {
//             setState(() => selectedPaymentMethod = value!);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalSection(double subtotal, double deliveryFee, double total) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Subtotal: \$${subtotal.toStringAsFixed(2)}",
//             style: const TextStyle(fontSize: 16)),
//         Text("Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}",
//             style: const TextStyle(fontSize: 16)),
//         const Divider(),
//         Text("Total: \$${total.toStringAsFixed(2)}",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }
// }

import 'package:fit_bowl_2/presentation/UI/secreens/home_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/order-status.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/shop_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/cart_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedPaymentMethod = "Credit Card";
  final TextEditingController addressController = TextEditingController();

  late CartController _cartController;
  late ProductController _productController;
  late OrderController _orderController;
  bool isLoading = true;
  String errorMessage = '';
  late String currentUserId;
  List<Sale> cartSales = [];
  Map<String, Product?> productCache = {}; // Cache for products

  double subtotal = 0.0;
  double deliveryFee = 5.0;

  @override
  void initState() {
    super.initState();
    _cartController = Get.find();
    _productController = Get.find();
    _orderController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;
    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    try {
      setState(() => isLoading = true);
      final cart = await _cartController.getCartByUserId(currentUserId);
      if (cart != null) {
        cartSales = cart.salesIds;
        subtotal = cartSales.fold(0.0, (sum, sale) => sum + sale.totalPrice);
      }
      setState(() => isLoading = false);
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load cart data: $error';
      });
    }
  }

  Future<Product?> _fetchProduct(String productId) async {
    if (productCache.containsKey(productId)) {
      return productCache[productId]; // Return cached product
    }

    final success = await _productController.getProductById(productId);
    if (success) {
      productCache[productId] = _productController.selectedProduct;
      return _productController.selectedProduct;
    }
    return null;
  }

  void _placeOrder() async {
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠ Please enter a delivery address")),
      );
      return;
    }

    try {
      setState(() => isLoading = true);
      final order = await _orderController.placeOrder(
          currentUserId, addressController.text, selectedPaymentMethod);
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Order Placed Successfully!")),
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderStatusScreen(),
      ));
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to place order: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: const TextStyle(fontSize: 18)),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _buildSectionTitle("🛍 Order Summary"),
                      const SizedBox(height: 10),
                      ...cartSales.map((sale) => FutureBuilder<Product?>(
                            future: _fetchProduct(sale.productId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text(
                                    'Product details unavailable');
                              }
                              final product = snapshot.data!;
                              return _buildOrderItem(
                                product.image,
                                product.name!,
                                sale.quantity,
                                sale.totalPrice,
                              );
                            },
                          )),
                      const SizedBox(height: 40),
                      _buildSectionTitle("📍 Delivery Address"),
                      const SizedBox(height: 10),
                      _buildAddressInput(),
                      const SizedBox(height: 40),
                      _buildSectionTitle("💳 Payment Method"),
                      const SizedBox(height: 10),
                      _buildPaymentMethod(),
                      const SizedBox(height: 40),
                      _buildSectionTitle("🏷 Order Total"),
                      const SizedBox(height: 10),
                      _buildTotalSection(subtotal, deliveryFee, total),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Confirm Order"),
                                content: const Text(
                                    "Are you sure you want to place this order?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      _placeOrder(); // Call the place order function
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            "Confirm Order",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }

  Widget _buildOrderItem(
      String imageUrl, String name, int quantity, double price) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl,
                  width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Text("\$${(price * quantity).toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressInput() {
    return TextField(
      controller: addressController,
      decoration: InputDecoration(
        hintText: "Enter your delivery address",
        prefixIcon: const Icon(Icons.location_on, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButton<String>(
          value: selectedPaymentMethod,
          isExpanded: true,
          underline: const SizedBox(),
          items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
            return DropdownMenuItem(
                value: method,
                child: Text(method, style: const TextStyle(fontSize: 16)));
          }).toList(),
          onChanged: (value) {
            setState(() => selectedPaymentMethod = value!);
          },
        ),
      ),
    );
  }

  Widget _buildTotalSection(double subtotal, double deliveryFee, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Subtotal: \$${subtotal.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 16)),
        Text("Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 16)),
        const Divider(),
        Text("Total: \$${total.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}
