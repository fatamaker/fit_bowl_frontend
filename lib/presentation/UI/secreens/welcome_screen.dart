// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/auto_login_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/home_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/login_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleNavigation(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    bool res = true;

    Get.put(AuthenticationController());
    final AuthenticationController authController = Get.find();

    // Auto-login logic
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();
    autologiVarReturn.fold((l) {
      res = false;
    }, (r) async {
      print(r.toString());
      if (r != null) {
        authController.token = r;
        final user = await GetUserByIdUsecase(sl()).call(userId: r.userId);
        user.fold((l) {
          res = false;
        }, (r) async {
          authController.currentUser = r;
          // await wishListController
          //     .getUserWishlist(authController.currentUser.id!);
          // await cartController.getUserCart(authController.currentUser.id!);
          // Get.put(NotificationsController());
        });
        print(authController.currentUser.birthDate);
      } else {
        res = false;
      }
    });

    setState(() {
      isLoading = false;
    });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => res ? const HomeScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADEBB3),
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6ED),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(44),
                  bottomRight: Radius.circular(44),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'GreenBowl',
                    style: TextStyle(
                      fontFamily: 'LilitaOne',
                      fontSize: 40,
                      color: const Color(0xFF1B6A3D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '"Your Salad, Your Way!"',
                    style: TextStyle(
                      fontFamily: 'LilitaOne',
                      fontSize: 25,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assetes/salde-removebg.png',
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Image failed to load');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => handleNavigation(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 21, 141, 85);
                          }
                          return const Color(0xFF125B3C);
                        },
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 10;
                          }
                          return 7;
                        },
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'LilitaOne',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
