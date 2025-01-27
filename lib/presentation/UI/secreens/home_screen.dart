import 'package:fit_bowl_2/presentation/UI/secreens/category_product_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/order_history_page.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/profil_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/saladepage.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/wishlist_page.dart';

import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';

import 'package:fit_bowl_2/presentation/UI/secreens/shop_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/botton_nav_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  bool _isSearching = false;
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();

  // Define pages
  final List<Widget> _pages = [
    ShopScreen(),
    const WishlistPage(),
    ProfileScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF3F6ED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFFF3F6ED),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
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
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: Color(0xFFD9D9D9),
                    child: GetBuilder<AuthenticationController>(
                        builder: (controller) {
                      final currentUser = controller.currentUser;
                      return Row(
                        children: [
                          // Profile Picture
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                currentUser.imageUrl!,
                              ), // Load profile image from URL
                            ),
                          ),

                          Text(
                            '${currentUser.firstName}  ${currentUser.lastName}', // Combine first and last name
                            style: TextStyle(
                              fontFamily: 'LilitaOne',
                              fontSize: 23,
                              color: const Color.fromARGB(255, 13, 11, 11),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                ),
                // command history
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryPage(
                            orderHistoryItems: [
                              {
                                'orderId': 1,
                                'product': 'Item 1',
                                'quantity': 2,
                                'totalPrice': 29.99,
                                'date': '2025-01-20',
                              },
                              {
                                'orderId': 2,
                                'product': 'Item 2',
                                'quantity': 1,
                                'totalPrice': 15.50,
                                'date': '2025-01-18',
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_cart_rounded,
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                      title: Text(
                        'order history',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                      ),
                    ),
                  ),
                ),
                // About page
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Saladepage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                      title: Text(
                        'FAQ',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                      ),
                    ),
                  ),
                ),

                // categorys

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategoryProductScreen(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.category_outlined,
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                      title: Text(
                        'categorys',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                      ),
                    ),
                  ),
                ),
              ],
            ),

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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
