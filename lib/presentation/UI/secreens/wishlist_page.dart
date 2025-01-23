import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistPage({super.key, required this.wishlistItems});

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
      body: wishlistItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assetes/téléchargement__6_-removebg.png',
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No favored product yet. What are you waiting for? Add one!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return Dismissible(
                  key: Key(item['title']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    wishlistItems.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('${item['title']} removed from wishlist')),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete,
                            color: const Color.fromARGB(255, 125, 33, 33),
                            size: 30.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Remove',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 125, 33, 33),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: WishlistCard(
                    title: item['title'],
                    description: item['description'],
                    price: item['price'],
                    imageUrl: item['imageUrl'],
                    onRemove: () {},
                  ),
                );
              },
            ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final VoidCallback onRemove;

  const WishlistCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFD9D9D9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    price,
                    style: TextStyle(
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
