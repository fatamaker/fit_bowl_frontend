import 'package:fit_bowl_2/data/modeles/supplement_model.dart';
import 'package:fit_bowl_2/presentation/controllers/supplement_contoller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:get/get.dart';

class SaladeScreen extends StatefulWidget {
  final Product product;

  const SaladeScreen({super.key, required this.product});

  @override
  _SaladeScreenState createState() => _SaladeScreenState();
}

class _SaladeScreenState extends State<SaladeScreen> {
  late SizeInfo selectedSize;
  final List<bool> selectedAddOns = [false, false, false];
  final List<String> selectedSupplements = [];
  SupplementModel? selectedSupplement; // Define selected supplement
  int selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    selectedSize =
        widget.product.sizes?.small ?? SizeInfo(price: 0, calories: 0);

    Get.put(SupplementController());
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F6ED),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info Section
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(product.image),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.name ?? "No name available",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Taille: ${selectedSize == widget.product.sizes?.small ? 'S' : selectedSize == widget.product.sizes?.medium ? 'M' : 'L'}        '
                      'calories: ${selectedSize.calories ?? 0}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Ingrédients Section
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingrédients',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description != null
                          ? product.description!
                              .split(
                                  '•') // Split the description into a list by commas
                              .map((item) =>
                                  '• ${item.trim()}') // Add a bullet to each item
                              .join(
                                  '\n') // Join items back with a newline character
                          : "No ingredients available",
                      style: const TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                'Sizes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Size Options
            _buildSizeOptions(product.sizes),
            const SizedBox(height: 60),

            // Add-Ons Section
            Center(
              child: const Text(
                'Souhaitez-vous des suppléments :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // // Supplement options
            // ...product.suppIds?.map((id) => _buildAddOnOption(id)) ?? [],
            // const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Combien de bol :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (selectedQuantity > 1) selectedQuantity--;
                        });
                      },
                    ),
                    Text('$selectedQuantity', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          selectedQuantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 100),

            // Add to Cart Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  final totalAddOnPrice = _calculateAddOnPrice();
                  final totalPrice = selectedSize.price + totalAddOnPrice;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Added to cart for $totalPrice Dinar(s)!')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnOption(String suppId) {
    final SupplementController controller = Get.find();

    controller.getSupplementById(suppId);

    return GetBuilder<SupplementController>(
      builder: (controller) {
        if (controller.supplement == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Text(
            'Failed to load supplement for ID $suppId',
            style: const TextStyle(color: Colors.red),
          );
        } else {
          final supplement = controller.supplement;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${supplement!.name} +${supplement.price}D +${supplement.calories}cal',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Checkbox(
                value: selectedSupplements.contains(suppId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedSupplements.add(suppId);
                    } else {
                      selectedSupplements.remove(suppId);
                    }
                  });
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildSizeOptions(ProductSize? sizes) {
    if (sizes == null) return const Text('No sizes available');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSizeOption('Small', sizes.small),
        _buildSizeOption('Medium', sizes.medium),
        _buildSizeOption('Large', sizes.large),
      ],
    );
  }

  Widget _buildSizeOption(String label, SizeInfo? sizeInfo) {
    if (sizeInfo == null) return Container();

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = sizeInfo; // Update selected size
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              selectedSize == sizeInfo ? Colors.green.shade100 : Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${sizeInfo.price}D'),
            Text('${sizeInfo.calories ?? 0} cal'),
          ],
        ),
      ),
    );
  }

  int _calculateAddOnPrice() {
    // Add-on prices
    const addOnPrices = [2, 2, 3];
    int total = 0;
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        total += addOnPrices[i];
      }
    }
    return total;
  }
}
