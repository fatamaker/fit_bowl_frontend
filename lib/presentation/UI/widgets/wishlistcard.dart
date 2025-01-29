import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Map<String, Map<String, double>>
      sizesData; // Includes price and calories
  final VoidCallback onRemove;

  const WishlistCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.sizesData,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductDetailsScreen with image transition
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              title: title,
              imageUrl: imageUrl,
              sizesData: sizesData,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Hero Widget for image transition
              Hero(
                tag: '$title-$imageUrl',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    imageUrl,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Only showing product title here
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12.0),

              // Favorite Button with Animation
              GestureDetector(
                onTap: () {
                  // Trigger remove action
                  Future.delayed(const Duration(milliseconds: 300), () {
                    onRemove();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final Map<String, Map<String, double>>
      sizesData; // Includes price and calories

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.sizesData,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isRotated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hero Widget for image transition with rotation
            Hero(
              tag: widget.imageUrl,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                transform: Matrix4.rotationZ(isRotated ? 0.5 : 0),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isRotated = !isRotated;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget.imageUrl,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // UI Elements with Icons
            Row(
              children: [
                Icon(Icons.food_bank_rounded,
                    color: const Color.fromARGB(255, 228, 149, 22), size: 30),
                const SizedBox(width: 8),
                Text(
                  'Size, Price & Calories:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Display each size, price, and calories with an icon
            Expanded(
              child: ListView(
                children: widget.sizesData.entries.map((entry) {
                  return ListTile(
                    leading: Icon(Icons.restaurant_menu, color: Colors.green),
                    title: Text('${entry.key} Size'),
                    subtitle: Row(
                      children: [
                        Icon(Icons.monetization_on,
                            color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '\$${entry.value['price']!.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.local_fire_department,
                            color: Colors.red, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${entry.value['calories']} cal',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.info_outline, color: Colors.grey),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
