import 'package:flutter/material.dart';

class Saladepage extends StatefulWidget {
  const Saladepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SaladeScreenState createState() => _SaladeScreenState();
}

class _SaladeScreenState extends State<Saladepage> {
  String selectedSize = "M";
  int selectedQuantity = 1;
  List<bool> selectedAddOns = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F6ED),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                                'assets/Boulangerie_Grissol_Croutons_Spring_Mix_Salad_Recipe-removebg-preview.png'), // Replace with your image
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Salade Mélange printanier',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Taille: S        calories: 125',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // Ingrédients Section
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingrédients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• 500 ml de coriandre\n• 2 pommes de terre\n• 15 ml de pistache\n• 200 ml de poulet',
                            style: TextStyle(height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Choisissez une taille :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSizeOption('S', '125 cal\n10.00D'),
                      _buildSizeOption('M', '215 cal\n15.00D'),
                      _buildSizeOption('L', '310 cal\n20.00D'),
                    ],
                  ),
                  SizedBox(height: 60),
                  Center(
                    child: Text(
                      'Souhaitez vous des suppléments :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildAddOnOption(0, '80 ml de yaourt grec', 2, 110),
                  _buildAddOnOption(1, '40 ml de mayonnaise', 2, 150),
                  _buildAddOnOption(2, '30 ml de ciboulette', 3, 70),
                  SizedBox(height: 30),
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
                          Text('$selectedQuantity',
                              style: TextStyle(fontSize: 18)),
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
                  SizedBox(
                      height: 100), // Add spacing to prevent content overlap
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Add to cart logic
              },
              child: Text('Ajouter 1 pour 17.00D'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size, String details) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedSize == size ? Colors.green.shade100 : Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 80,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(size,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(details,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnOption(int index, String title, int price, int calories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$title +${price}D   +${calories}cal',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Checkbox(
          value: selectedAddOns[index],
          onChanged: (bool? value) {
            setState(() {
              selectedAddOns[index] = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
