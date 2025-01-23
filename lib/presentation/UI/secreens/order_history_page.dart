import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderHistoryItems;

  const OrderHistoryPage({super.key, required this.orderHistoryItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: orderHistoryItems.isEmpty
          ? Center(
              child: Text(
                'No orders yet!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Orders', // This text will appear on the page
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'LilitaOne',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: orderHistoryItems.length,
                    itemBuilder: (context, index) {
                      final item = orderHistoryItems[index];
                      return OrderHistoryCard(
                        orderId: item['orderId'],
                        product: item['product'],
                        quantity: item['quantity'],
                        totalPrice: item['totalPrice'],
                        date: item['date'],
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
  final int orderId;
  final String product;
  final int quantity;
  final double totalPrice;
  final String date;

  const OrderHistoryCard({
    super.key,
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFD9D9D9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: $orderId',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Product: $product',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Quantity: $quantity',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Order Date: $date',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
