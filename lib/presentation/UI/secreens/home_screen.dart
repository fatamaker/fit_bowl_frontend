import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/confirmation_screen.dart';

import 'package:fit_bowl_2/presentation/UI/secreens/order_history_page.dart';

import 'package:fit_bowl_2/presentation/UI/secreens/profil_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/wishlist_page.dart';

import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
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
  final TextEditingController _searchController = TextEditingController();

  final ProductController productController = Get.find();

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
            _isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: 230,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                          ),
                          autofocus: true,
                          onChanged: (value) {
                            productController.searchProducts(value);
                          },
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
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.close,
                      color: Color.fromARGB(255, 61, 60, 60)),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: Color(0xFFD9D9D9),
                    child: GetBuilder<AuthenticationController>(
                        builder: (controller) {
                      final currentUser = controller.currentUser;
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  (controller.currentUser.imageUrl?.isEmpty ??
                                          true)
                                      ? const AssetImage(
                                          "assetes/salde-removebg.png")
                                      : NetworkImage(
                                              controller.currentUser.imageUrl!)
                                          as ImageProvider,
                              radius: 40,
                            ),
                          ),
                          Text(
                            '${currentUser.firstName}  ${currentUser.lastName}',
                            style: TextStyle(
                              fontFamily: 'LilitaOne',
                              fontSize: 18,
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
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryPage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.format_list_numbered_sharp,
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
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(),
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
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_cart_checkout_rounded,
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                      title: Text(
                        'cart',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 60, 60)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
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
