import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/home_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/order_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartController _cartController;
  late ProductController _productController;
  late String currentUserId;
  bool isLoading = true;
  String errorMessage = '';
  List<Sale> cartSales = [];
  Map<String, Product?> productCache = {}; // Cache for fetched products

  @override
  void initState() {
    super.initState();
    _cartController = Get.find();
    _productController = Get.find();

    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;

    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    try {
      final cart = await _cartController.getCartByUserId(currentUserId);
      setState(() {
        cartSales = cart!.salesIds;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load cart data: $error';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(
            fontFamily: 'LilitaOne',
            fontSize: 25,
            color: const Color.fromARGB(255, 13, 11, 11),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 18),
                  ),
                )
              : GetBuilder<CartController>(
                  // Ensures UI updates instantly
                  builder: (cartController) {
                    final cartSales = cartController.cartSales;

                    return cartSales.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: cartSales.length +
                                1, // Extra item for the button
                            itemBuilder: (context, index) {
                              if (index == cartSales.length) {
                                final total = cartSales.fold(
                                  0.0,
                                  (sum, sale) => sum + sale.totalPrice,
                                );

                                if (total == 0) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.shopping_cart,
                                            size: 80, color: Colors.grey),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Your cart is empty. Add some sales to get started!',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        'Total: \$${total.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Order Summary'),
                                              content: Text(
                                                'Your total order amount is \$${total.toStringAsFixed(2)}.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderScreen(),
                                                    ),
                                                  ),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 24.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                        child: Text(
                                          'Order Now - \$${total.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              final sale = cartSales[index];
                              return Dismissible(
                                key: Key(sale.id),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm Deletion"),
                                        content: const Text(
                                            "Are you sure you want to remove this item from the cart?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onDismissed: (direction) async {
                                  // Remove from local UI first
                                  cartController.cartSales.removeWhere(
                                      (item) => item.id == sale.id);
                                  cartController.update();

                                  // Ensure the widget is still mounted before accessing the context
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Sale for product ${sale.productId} removed from cart')),
                                    );
                                  }

                                  // Perform backend removal
                                  await cartController.removeSaleFromCart(
                                      currentUserId, sale.id);
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(Icons.delete,
                                          color:
                                              Color.fromARGB(255, 125, 33, 33),
                                          size: 30.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Remove',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 125, 33, 33),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: FutureBuilder<Product?>(
                                  future: _fetchProduct(sale.productId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Text('Product not found');
                                    }
                                    final product = snapshot.data!;
                                    return CartSaleCard(
                                      productName: product.name,
                                      productImageUrl: product.image,
                                      quantity: sale.quantity,
                                      totalPrice: sale.totalPrice,
                                      totalCalories: sale.totalCalories,
                                      supplements: sale.supplements,
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart,
                                    size: 80, color: Colors.grey),
                                const SizedBox(height: 10),
                                const Text(
                                  'Your cart is empty. Add some sales to get started!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                  },
                ),
    );
  }
}

class CartSaleCard extends StatelessWidget {
  final String? productName;
  final String productImageUrl;
  final int quantity;
  final double totalPrice;
  final double totalCalories;
  final List<String> supplements;

  const CartSaleCard({
    super.key,
    this.productName,
    required this.productImageUrl,
    required this.quantity,
    required this.totalPrice,
    required this.totalCalories,
    required this.supplements,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 6.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        productImageUrl,
                        width: 140,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16.0),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      productName!,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Quantity
                    Row(
                      children: [
                        const Icon(Icons.shopping_cart,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8.0),
                        Text(
                          'Quantity: $quantity',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Total Price
                    Row(
                      children: [
                        const Icon(Icons.attach_money,
                            size: 18, color: Colors.green),
                        const SizedBox(width: 8.0),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Total Calories
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department,
                            size: 18, color: Colors.orange),
                        const SizedBox(width: 8.0),
                        Text(
                          '$totalCalories kcal',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Supplements
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: supplements
                          .map(
                            (supplement) => Chip(
                              label: Text(
                                supplement,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              backgroundColor: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
