import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Lottie Animation
            SizedBox(
              height: 200,
              child: Lottie.asset(
                'assetes/animations/salade_about.json', // Replace with your Lottie animation file path
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our App: Your Personalized Salad Experience',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              "Discover our mobile application dedicated to selling delicious and customizable salads. We empower users to create their perfect salad by selecting from a wide range of fresh ingredients, all while providing real-time calorie information for each item.",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              "Experience the future of food ordering with our innovative Augmented Reality (AR) feature. Visualize your custom salad in your own space before you even place your order, ensuring it looks exactly as you imagined.",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              "Our mission is to encourage healthy eating habits by providing you with the tools to understand and manage your calorie intake. We believe in offering an immersive and interactive experience that helps you make informed and delicious food choices.",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30.0),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Order Your Own Salad'),
            ),
            ListTile(
              leading: Icon(Icons.whatshot),
              title: Text('Real-time Calorie Information'),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Augmented Reality Salad Visualization'),
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Wide Selection of Fresh Ingredients'),
            ),
            SizedBox(height: 20.0),
            Text(
              'We are passionate about helping you eat well and enjoy the process. Green Bowl!',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
