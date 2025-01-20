import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordscreen extends StatelessWidget {
  ResetPasswordscreen({super.key});
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6ED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Decorative Container for Title
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF125B3C),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontFamily: 'LilitaOne',
                        fontSize: 40,
                        color: const Color(0xFFADEBB3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your new password below to reset it.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Password TextField
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    filled: true,
                    fillColor: const Color(0xFFADEBB3).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Confirm Password TextField
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: const Color(0xFFADEBB3).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ),

              const SizedBox(height: 30),

              // Reset Button
              ElevatedButton(
                onPressed: () async {
                  final AuthenticationController controller = Get.find();
                  await controller.resetPassword(
                      passwordController, confirmpasswordController, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF125B3C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 7,
                ),
                child: const Text(
                  'Reset Password',
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
      ),
    );
  }
}
