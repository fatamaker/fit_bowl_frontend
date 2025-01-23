import 'package:fit_bowl_2/presentation/UI/widgets/profil_image_dialog.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageContainer extends StatelessWidget {
  final String? imageUrl;

  const ImageContainer({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController controller = Get.find();

    return Stack(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: CircleAvatar(
            backgroundImage: (controller.currentUser.imageUrl?.isEmpty ?? true)
                ? const AssetImage("assetes/salde-removebg.png")
                : NetworkImage(controller.currentUser.imageUrl!)
                    as ImageProvider,
            radius: 60,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) => const ProfileImageDialog(),
              );
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
