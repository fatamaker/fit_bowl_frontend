import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/shop_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/botton_nav_bar.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // Current selected tab index
  // ignore: unused_field
  int _selectedIndex = 0;
  bool _isSearching = false; // Boolean to toggle search bar visibility
  // ignore: prefer_final_fields
  TextEditingController _searchController =
      TextEditingController(); // Controller for the search input

  // Method to update the selected index when the bottom nav bar changes
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final cartProducts = [
    Product(
      id: '1',
      name: 'Salade Mélange printanier',
      image: 'assets/salad_image.png',
      reference: 'REF001',
      category: 'Salads',
      suppIds: [],
      sizes: {'default': SizeInfo(price: 17.0, calories: 150)},
    ),
    Product(
      id: '2',
      name: 'Salade César',
      image: 'assets/salad_image_2.png',
      reference: 'REF002',
      category: 'Salads',
      suppIds: [],
      sizes: {'default': SizeInfo(price: 20.0, calories: 200)},
    ),
  ];

// Pass this to CartScreen:

  // Pages to display based on the selected index
  final List<Widget> _pages = [
    // Shop page
    const ShopScreen(),

    // Cart page
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6ED),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),

      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(70), // Set the custom height for the AppBar
        child: AppBar(
          backgroundColor: const Color(0xFFF3F6ED),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // This will work correctly now
              },
              icon: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 61, 60, 60),
              ),
            ),
          ),
          actions: [
            // If _isSearching is true, show the TextField, else show the search icon
            _isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: 230,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Add padding inside the TextField
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                          ),
                          autofocus: true,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.search,
                          color: Color.fromARGB(255, 61, 60, 60)),
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                  ),
            // Close the search bar if it is open
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.close,
                      color: Color.fromARGB(255, 61, 60, 60)),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear(); // Clear the search input
                    });
                  },
                ),
              ),
          ],
        ),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFD9D9D9),
        child: Column(
          children: [
            // Logo and other pages
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                DrawerHeader(
                  child: Image.asset(
                    'assetes/salde-removebg.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                // command history
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart_rounded,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                    title: Text(
                      'command history',
                      style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                    ),
                  ),
                ),
                // About page
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                    title: Text(
                      'FAQ',
                      style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                    ),
                  ),
                ),

                // categorys
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.category_outlined,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                    title: Text(
                      'categorys',
                      style: TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                    ),
                  ),
                ),
              ],
            ),

            // Spacer pushes the Logout button to the bottom
            const Spacer(),

            // Logout button
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 61, 60, 60),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color.fromARGB(255, 61, 60, 60),
                  ),
                ),
                onTap: () async {
                  final AuthenticationController authenticationController =
                      Get.find();
                  await authenticationController.logout(context);
                },
              ),
            ),
          ],
        ),
      ),

      // Display the currently selected page
      body: _pages[_selectedIndex],
    );
  }
}
