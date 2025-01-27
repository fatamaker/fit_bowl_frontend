import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:fit_bowl_2/domain/entities/product.dart'; // Ensure correct import for Product entity

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late WishlistController _wishlistController;
  late ProductController _productController;
  late String currentUserId;
  bool isLoading = true;
  String errorMessage = '';
  List<Product?> wishlistProducts = [];

  @override
  void initState() {
    super.initState();
    _wishlistController = Get.find();
    _productController = Get.find();

    // Fetch the current user ID from the AuthenticationController
    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;

    // Fetch the wishlist and the products for the current user
    _loadWishlist();
  }

  // Function to load the wishlist and products
  void _loadWishlist() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Fetch the wishlist for the current user
    final success =
        await _wishlistController.getWishlistByUserId(currentUserId);
    if (success) {
      // Fetch products based on the wishlist
      await _loadProducts();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load wishlist';
      });
    }
  }

  // Function to load products based on wishlist data
  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
    });

    final productIds = _wishlistController.userWishlist?.productIds;

    if (productIds!.isEmpty) {
      setState(() {
        wishlistProducts = []; // No products to display
        isLoading = false;
      });
      return;
    }

    List<Product?> fetchedProducts = [];

    for (String productId in productIds) {
      final success = await _productController.getProductById(productId);
      print(success);
      if (success && _productController.selectedProduct != null) {
        // Only add the product if it's valid
        fetchedProducts.add(_productController.selectedProduct);
      } else {
        // Optionally, handle the case when product is not found
        print('Product with ID $productId not found.');
      }
    }

    setState(() {
      wishlistProducts = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wish list',
          style: TextStyle(
            fontFamily: 'LilitaOne',
            fontSize: 25,
            color: const Color.fromARGB(255, 13, 11, 11),
          ),
        ),
        centerTitle: true,
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
              : wishlistProducts.isNotEmpty
                  // When there are wishlist products
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: wishlistProducts.length,
                      itemBuilder: (context, index) {
                        final product = wishlistProducts[index];
                        return Dismissible(
                          key: Key(product!.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            await _wishlistController.removeProductFromWishlist(
                                currentUserId, product.id);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${product.name} removed from wishlist'),
                              ),
                            );
                            _loadWishlist(); // Reload the wishlist after removal
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.delete,
                                    color: Color.fromARGB(255, 125, 33, 33),
                                    size: 30.0),
                                SizedBox(width: 10.0),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 125, 33, 33),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: WishlistCard(
                            title: product.name!,
                            description: product.reference!,
                            price: product.sizes!.small!.price,
                            imageUrl: product.image,
                          ),
                        );
                      },
                    )
                  // When the wishlist is empty
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assetes/téléchargement__6_-removebg.png',
                            height: 100,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No favored product yet. What are you waiting for? Add one!',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  const WishlistCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFD9D9D9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    price.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
