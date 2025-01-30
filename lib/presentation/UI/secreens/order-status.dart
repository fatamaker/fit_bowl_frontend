import 'package:flutter/material.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  String orderStatus =
      "Pending"; // Order statuses: Pending, Confirmed, Out for Delivery, Delivered
  int estimatedDeliveryTime = 30; // Estimated minutes for delivery

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Order Status",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📦 ORDER TRACKING STATUS
            _buildSectionTitle("📦 Order Status"),
            const SizedBox(height: 10),
            _buildOrderTracking(),
            const SizedBox(height: 30),

            // 🚚 ESTIMATED DELIVERY TIME
            _buildSectionTitle("🚚 Estimated Delivery Time"),
            const SizedBox(height: 10),
            _buildDeliveryTime(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildOrderTracking() {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Status: $orderStatus",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _getOrderProgress(),
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 6.0,
            ),
          ],
        ),
      ),
    );
  }

  double _getOrderProgress() {
    switch (orderStatus) {
      case "Confirmed":
        return 0.3;
      case "Out for Delivery":
        return 0.7;
      case "Delivered":
        return 1.0;
      default:
        return 0.1;
    }
  }

  Widget _buildDeliveryTime() {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.timer, color: Colors.orange, size: 30),
            const SizedBox(width: 10),
            Text(
              "Estimated: $estimatedDeliveryTime mins",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
