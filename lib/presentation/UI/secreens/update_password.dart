// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

// class UpdatePasswordScreen extends StatelessWidget {
//   UpdatePasswordScreen({super.key});

//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController oldPasswordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F6ED),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Header Section
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF125B3C),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(44),
//                     bottomRight: Radius.circular(44),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 40,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Update Password',
//                       style: TextStyle(
//                         fontFamily: 'LilitaOne',
//                         fontSize: 40,
//                         color: const Color(0xFFADEBB3),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Enter your old and new password to update.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 40),

//               // Form Section
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     children: [
//                       // Old Password TextField
//                       TextFormField(
//                         controller: oldPasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'Old Password',
//                           filled: true,
//                           fillColor: const Color(0xFFADEBB3).withOpacity(0.5),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your old password';
//                           }
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 20),

//                       // New Password TextField
//                       TextFormField(
//                         controller: newPasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'New Password',
//                           filled: true,
//                           fillColor: const Color(0xFFADEBB3).withOpacity(0.5),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a new password';
//                           }
//                           if (value.length < 8) {
//                             return 'Password must be at least 8 characters long';
//                           }
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 30),

//                       // Update Button
//                       GetBuilder<AuthenticationController>(
//                         builder: (controller) {
//                           return ElevatedButton(
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate()) {
//                                 // Trigger password update logic
//                                 await controller.updatePassword(
//                                   oldPasswordController,
//                                   newPasswordController,
//                                   context,
//                                 );
//                               } else {
//                                 Fluttertoast.showToast(
//                                   msg: "Please fill in all required fields",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.TOP,
//                                   timeInSecForIosWeb: 1,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0,
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF125B3C),
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 50,
//                                 vertical: 15,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               elevation: 7,
//                             ),
//                             child: const Text(
//                               'Update Password',
//                               style: TextStyle(
//                                 fontFamily: 'LilitaOne',
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Old Password Input
                _buildTextField(
                  controller: _oldPasswordController,
                  label: "Old Password",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your old password"
                      : null,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                // New Password Input
                _buildTextField(
                  controller: _newPasswordController,
                  label: "New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a new password";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    }
                    return null;
                  },
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 30),
                // Update Button
                _buildUpdateButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1B6A3D)),
          prefixIcon: Icon(icon, color: const Color(0xFF1B6A3D)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1B6A3D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1B6A3D)),
          ),
        ),
        validator: validator,
      ),
    );
  }

  // Custom Update Button
  Widget _buildUpdateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final controller = Get.find<AuthenticationController>();
            await controller.updatePassword(
              _oldPasswordController,
              _newPasswordController,
              context,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Please fill in all required fields",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B6A3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          "Update Password",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
