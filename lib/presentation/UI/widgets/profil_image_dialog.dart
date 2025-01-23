import 'package:fit_bowl_2/core/utils/string_const.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImageDialog extends StatelessWidget {
  const ProfileImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      id: ControllerID.UPDATE_USER_IMAGE,
      builder: (controller) {
        return AlertDialog(
          title: const Text(
            "Update Profile Picture",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: controller.userImage == ''
                        ? Image.asset('assetes/userImage.jpeg').image
                        : controller.f == null
                            ? NetworkImage(controller.userImage)
                            : Image.file(controller.f!).image,
                  ),
                ),
                if (controller.currentUser.imageUrl != '')
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () async {
                          controller.setuserImage(controller.userImage == ''
                              ? controller.currentUser.imageUrl!
                              : '');
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.updateImage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAF6767),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
