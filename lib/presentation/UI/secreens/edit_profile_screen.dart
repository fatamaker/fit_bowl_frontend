import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the AuthenticationController instance
    final AuthenticationController authenticationController = Get.find();

    // Pre-fill the text fields with the current user data
    final currentUser = authenticationController.currentUser;
    firstNameController.text = currentUser.firstName;
    lastNameController.text = currentUser.lastName;
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone ?? '';
    addressController.text = currentUser.address ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF1B6A3D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Name Field
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Last Name Field
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Email Field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Phone Field
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Address Field
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Birth Date Field
            TextField(
              controller: birthDateController,
              decoration: const InputDecoration(
                labelText: 'Birth Date (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              onPressed: () async {
                try {
                  await authenticationController.updateProfile(
                    address: addressController.text,
                    firstName: firstNameController,
                    lastName: lastNameController,
                    phone: phoneController,
                    id: currentUser.id,
                    birthDate: birthDateController.text,
                    gender: currentUser.gender ?? '',
                    context: context,
                  );

                  // Show success message
                  Fluttertoast.showToast(
                    msg: 'Profile updated successfully!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  // Navigate back
                  Get.back();
                } catch (error) {
                  Fluttertoast.showToast(
                    msg: 'Failed to update profile: $error',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B6A3D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
