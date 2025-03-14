// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for text fields
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   String? _selectedGender;
//   String? _birthDate;
//   DateTime? _selectedBirthdate;

//   final DateFormat format = DateFormat("yyyy-MM-dd");

//   void _pickBirthdate(BuildContext context) async {
//     DateTime initialDate = _selectedBirthdate ?? DateTime.now();
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _selectedBirthdate = pickedDate;
//         _birthDate = format.format(_selectedBirthdate!);
//       });
//     }
//   }

//   final AuthenticationController authenticationController = Get.find();

//   @override
//   void initState() {
//     super.initState();

//     // Populate fields with current user data
//     _firstNameController.text = authenticationController.currentUser.firstName;
//     _lastNameController.text = authenticationController.currentUser.lastName;
//     _phoneController.text = authenticationController.currentUser.phone!;
//     _addressController.text = authenticationController.currentUser.address!;
//     _birthDate = authenticationController.currentUser.birthDate != null
//         ? format.format(authenticationController.currentUser.birthDate!)
//         : '';

//     _selectedGender = authenticationController.currentUser.gender;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         backgroundColor: const Color(0xFF1B6A3D),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _firstNameController,
//                   decoration: const InputDecoration(
//                     labelText: "First Name",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your first name";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _lastNameController,
//                   decoration: const InputDecoration(
//                     labelText: "Last Name",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your last name";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: const InputDecoration(
//                     labelText: "Address",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your address";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: const InputDecoration(
//                     labelText: "Phone",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: _selectedGender,
//                   decoration: const InputDecoration(
//                     labelText: "Gender",
//                     border: OutlineInputBorder(),
//                   ),
//                   items: ['male', 'female', '']
//                       .map((gender) => DropdownMenuItem(
//                             value: gender,
//                             child: Text(gender),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGender = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please select your gender";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () => _pickBirthdate(context),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: "Birthdate",
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       controller: TextEditingController(text: _birthDate),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Profile updated successfully!"),
//                           ),
//                         );
//                         authenticationController.updateProfile(
//                           firstName: _firstNameController,
//                           lastName: _lastNameController,
//                           address: _addressController.text,
//                           phone: _phoneController,
//                           id: authenticationController.currentUser.id,
//                           gender: _selectedGender!,
//                           birthDate: _birthDate!,
//                           context: context,
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1B6A3D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text(
//                       "Save",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedGender;
  String? _birthDate;
  DateTime? _selectedBirthdate;

  final DateFormat format = DateFormat("yyyy-MM-dd");

  void _pickBirthdate(BuildContext context) async {
    DateTime initialDate = _selectedBirthdate ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthDate = format.format(_selectedBirthdate!);
      });
    }
  }

  final AuthenticationController authenticationController = Get.find();

  @override
  void initState() {
    super.initState();

    // Populate fields with current user data
    _firstNameController.text = authenticationController.currentUser.firstName;
    _lastNameController.text = authenticationController.currentUser.lastName;
    _phoneController.text = authenticationController.currentUser.phone!;
    _addressController.text = authenticationController.currentUser.address!;
    _birthDate = authenticationController.currentUser.birthDate != null
        ? format.format(authenticationController.currentUser.birthDate!)
        : '';

    _selectedGender = authenticationController.currentUser.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // First Name Input
                _buildTextField(
                  controller: _firstNameController,
                  label: "First Name",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your first name"
                      : null,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                // Last Name Input
                _buildTextField(
                  controller: _lastNameController,
                  label: "Last Name",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your last name"
                      : null,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                // Address Input
                _buildTextField(
                  controller: _addressController,
                  label: "Address",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your address"
                      : null,
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 20),
                // Phone Input
                _buildTextField(
                  controller: _phoneController,
                  label: "Phone",
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20),
                // Gender Dropdown
                _buildDropdownField(
                  value: _selectedGender,
                  label: "Gender",
                  items: ['male', 'female', ''],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Birthdate Picker
                _buildDatePickerField(
                  context: context,
                  label: "Birthdate",
                  value: _birthDate,
                ),
                const SizedBox(height: 30),
                // Save Button
                _buildSaveButton(context),
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

  // Custom DropdownField Widget
  Widget _buildDropdownField({
    required String? value,
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1B6A3D)),
          prefixIcon: const Icon(Icons.transgender, color: Color(0xFF1B6A3D)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1B6A3D)),
          ),
        ),
        items: items
            .map((gender) =>
                DropdownMenuItem(value: gender, child: Text(gender)))
            .toList(),
        onChanged: onChanged,
        validator: (value) =>
            value == null || value.isEmpty ? "Please select your gender" : null,
      ),
    );
  }

  // Custom Date Picker Widget
  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    String? value,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () => _pickBirthdate(context),
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Color(0xFF1B6A3D)),
              prefixIcon:
                  const Icon(Icons.calendar_today, color: Color(0xFF1B6A3D)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1B6A3D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1B6A3D)),
              ),
            ),
            controller: TextEditingController(text: value),
          ),
        ),
      ),
    );
  }

  // Custom Save Button
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully!"),
              ),
            );
            authenticationController.updateProfile(
              firstName: _firstNameController,
              lastName: _lastNameController,
              address: _addressController.text,
              phone: _phoneController,
              id: authenticationController.currentUser.id,
              gender: _selectedGender!,
              birthDate: _birthDate!,
              context: context,
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
          "Save",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
