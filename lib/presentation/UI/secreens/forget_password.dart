// ignore_for_file: deprecated_member_use

import 'package:fit_bowl_2/presentation/UI/secreens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/login_screen.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
                  horizontal: 35,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      'Forget Password',
                      style: TextStyle(
                          fontFamily: 'LilitaOne',
                          fontSize: 40,
                          color: const Color(0xFFADEBB3)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Email TextField
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(),
                    ),
                  );
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
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'LilitaOne',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Back to Login Text
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Back to Login',
                  style: TextStyle(
                    color: Color(0xFF1B6A3D),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
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
