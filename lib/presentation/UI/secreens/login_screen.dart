import 'package:fit_bowl_2/presentation/UI/widgets/custom_text_field.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/forget_password.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6ED),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFF1B6A3D),
                          child: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Welcome back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 43, 56, 43),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          label: 'Email',
                          controller: emailController,
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: 'Password',
                          controller: passwordController,
                          icon: Icons.lock,
                          isObscure: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Forgot Password? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Color(0xFF1B6A3D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GetBuilder(
                            init: AuthenticationController(),
                            builder: (controller) {
                              return ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await controller.login(
                                        email: emailController,
                                        password: passwordController,
                                        context: context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: " all data required ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  // ignore: avoid_print
                                  print("Login successfully!");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B6A3D),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              );
                            }),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Create an account',
                                style: TextStyle(
                                  color: Color(0xFF1B6A3D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add logic for Facebook login
                              },
                              icon: const Icon(
                                Icons.facebook,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                // Add logic for Google login
                              },
                              icon: const Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
