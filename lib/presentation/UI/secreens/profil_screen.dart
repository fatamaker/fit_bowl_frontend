import 'package:fit_bowl_2/presentation/UI/secreens/edit_profile_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/update_password.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the instance of AuthenticationController using Get.find()
    // ignore: unused_local_variable
    final AuthenticationController authenticationController = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6ED),
      body: Center(
        child: GetBuilder<AuthenticationController>(
          // Set the ID for GetBuilder to update only when this controller changes
          builder: (controller) {
            // Access the currentUser from the controller
            final currentUser = controller.currentUser;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name and Email
                Text(
                  currentUser.firstName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  currentUser.lastName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  currentUser.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                // Edit Profile Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfileScreen(), // Replace with your Edit screen
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
                        builder: (context) =>
                            UpdatePasswordScreen(), // Replace with your Edit screen
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
    );
  }
}
