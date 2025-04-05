import 'package:fit_bowl_2/presentation/UI/secreens/edit_profile_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/update_password.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/image_container.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF3F6ED),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Center(
            child: GetBuilder<AuthenticationController>(
              builder: (controller) {
                final currentUser = controller.currentUser;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    // Profile Image
                    ImageContainer(imageUrl: currentUser.imageUrl),

                    // Name and Email
                    Text(
                      currentUser.firstName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      currentUser.lastName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _showUpdateEmailDialog(context, controller);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentUser.email,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.edit, size: 16, color: Colors.black),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B6A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Edit Password Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdatePasswordScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.lock, color: Colors.black),
                      label: const Text('Edit Password'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )));
  }
}

void _showUpdateEmailDialog(
    BuildContext context, AuthenticationController controller) {
  final TextEditingController emailController =
      TextEditingController(text: controller.currentUser.email);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update Email'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'New Email'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.updateEmail(emailController, context);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      );
    },
  );
}
