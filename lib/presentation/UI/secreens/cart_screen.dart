import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('cart'),
    );
  }
}



// import 'package:flutter/material.dart';

// class CartScreen extends StatelessWidget {
//   final List<Product> cartProducts;

//   const CartScreen({super.key, required this.cartProducts});

//   @override
//   Widget build(BuildContext context) {
//     double totalPrice = cartProducts.fold(
//       0.0,
//       (sum, product) => sum + product.sizes.values.first.price, // Example: taking the first size's price
//     );

//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade50,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             // Go back logic
//           },
//         ),
//         title: const Text(
//           'Panier',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = cartProducts[index];
//                   return ProductWidget(
//                     product: product,
//                     onRemove: () {
//                       // Handle product removal
//                       // Implement a mechanism to remove the product from the cart.
//                     },
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 // Checkout logic
//               },
//               child: Text(
//                 'Passer à la caisse ${totalPrice.toStringAsFixed(2)}D',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProductWidget extends StatelessWidget {
//   final Product product;
//   final VoidCallback onRemove;

//   const ProductWidget({
//     super.key,
//     required this.product,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: product.image != null
//                 ? Image.asset(
//                     product.image!,
//                     height: 60,
//                     width: 60,
//                     fit: BoxFit.cover,
//                   )
//                 : const Icon(Icons.image_not_supported, size: 60),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${product.sizes.values.first.price.toStringAsFixed(2)}D',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: onRemove,
//           ),
//         ],
//       ),
//     );
//   }
// }

