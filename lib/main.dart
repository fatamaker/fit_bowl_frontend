import 'package:fit_bowl_2/presentation/UI/secreens/welcome_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'di.dart' as di;

void main() async {
  // Dependency injection setup
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFFADEBB3)),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: WelcomeScreen(),
          );
        });
  }
}
