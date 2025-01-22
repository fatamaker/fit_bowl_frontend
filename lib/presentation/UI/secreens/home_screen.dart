import 'package:fit_bowl_2/presentation/UI/secreens/profil_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
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
    const ShopScreen(),
    const CartScreen(),
    ProfileScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String userName = "John Doe"; // Replace with actual user name
    final String profileImageUrl = 'assetes/salde-removebg.png';
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
                    child: Row(
                      children: [
                        // Profile Picture
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                                profileImageUrl), // Load profile image
                          ),
                        ),
                        // User Name
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontFamily: 'LilitaOne',
                              fontSize: 18,
                              color: const Color.fromARGB(255, 13, 11, 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
