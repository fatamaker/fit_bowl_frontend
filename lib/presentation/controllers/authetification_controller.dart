import 'dart:io';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/create_wishlistusecase.dart';
import 'package:path/path.dart';
import 'package:fit_bowl_2/core/utils/string_const.dart';
import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';
import 'package:fit_bowl_2/domain/entities/user.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/clear_user_image_usercase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/forget_password_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/login_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/logout_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/reset_password_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/update_image_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/update_password_usercase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/update_user_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/verify_otp_usecase.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/home_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/login_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/otp_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/reset_passwordScreen.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  late Token token;
  late String myemail; //Stores the user's email during password recovery.
  bool termsAccepted =
      false; //Tracks whether terms and conditions are accepted.
  bool isLoading =
      false; //Indicates whether an asynchronous operation is in progress.
  late User currentUser; //Represents the logged-in user's data.
  String userImage = '';
  XFile? img;
  File? f; // Converts the XFile into a File object for further processing.
  String? gender;
  String? birthDate;
  final ImagePicker _picker = ImagePicker();

  bool get missingData =>
      currentUser.phone == null ||
      currentUser.address == null ||
      currentUser.birthDate == null ||
      currentUser.gender == null;

  void setBirthDate(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    birthDate = '$year-$month-$day';
    update();
  }

  void setGender(String value) {
    gender = value;
    update();
  }

  void aceptTerms(bool v) {
    termsAccepted = v;
    update(['terms']);
  }

  // Future<void> pickImage() async {
  //   try {
  //     final img = await _picker.pickImage(source: ImageSource.gallery);
  //     if (img != null) {
  //       final f = File(img.path);
  //       setuserImage(basename(f.path));
  //     } else {
  //       // ignore: avoid_print
  //       print("No image selected");
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print("Error while picking image: $e");
  //   }
  // }

  Future<void> pickImage() async {
    try {
      img = await _picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        f = File(img!.path);
        setuserImage(basename(f!.path));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void setuserImage(String image) {
    userImage = image;
    update([ControllerID.UPDATE_USER_IMAGE]);
    update();
  }

  Future<String> createAccount(
      {required TextEditingController email,
      required TextEditingController firstName,
      required TextEditingController adresse,
      required TextEditingController lastName,
      required TextEditingController password,
      required TextEditingController cpassword,
      required BuildContext context}) async {
    final res = await CreateAccountUsecase(sl()).call(
        email: email.text,
        password: password.text,
        adresse: adresse.text,
        phone: '',
        firstName: firstName.text,
        lastName: lastName.text,
        imageUrl: '',
        birthDate: DateTime.parse("2020-07-17T03:18:31.177769-04:00"),
        gender: '');
    String userid = "";
    String message = '';
    res.fold((l) => message = l.message!, (r) async {
      print("Response from create account: $r");
      await CreateWishListUseCase(sl())(userId: r);

      // await CreateCartUsecase(sl())(userId: r);

      email.clear();
      password.clear();
      firstName.clear();
      lastName.clear();
      cpassword.clear();

      adresse.clear();
      gender = null;
      birthDate = null;
      termsAccepted = false;
      update();
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    update();
    return userid;
  }

  Future<void> login(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext context}) async {
    isLoading = true;
    update();
    final res =
        await LoginUsecase(sl())(email: email.text, password: password.text);

    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0), (r) async {
      token = r;
      email.clear();
      password.clear();
      // ignore: unused_local_variable
      final userRes = await getCurrentUser(r.userId);
      // ignore: use_build_context_synchronously
      //  await getOneUser(r.userId).then((value) async {
      //   final WishListController wishListController = Get.find();
      //   // final CartController cartController = Get.find();
      //   // final CategoryController categorControlller = Get.find();
      //   final AuthenticationController authController = Get.find();
      //   await wishListController
      //       .getUserWishlist(authController.currentUser.id!);
      //   // await cartController.getUserCart(authController.currentUser.id!);

      // });
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
    isLoading = false;
    update();
  }

  Future<void> logout(BuildContext context) async {
    isLoading = false;
    update();
    await LogoutUsecase(sl())();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  Future<void> sendFrogetPasswordRequest(TextEditingController useremail,
      String destionation, BuildContext context) async {
    String message = '';
    final res = await ForgetPasswordUsecase(sl())(
        email: useremail.text, destination: destionation);
    res.fold((l) => message = l.message!, (r) {
      myemail = useremail.text;
      useremail.clear();
      message = "email sent";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => OtpScreen()));
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> verifyOTP(
      TextEditingController otp, BuildContext context) async {
    if (otp.text.length == 4 && isNumeric(otp.text)) {
      final res = await OTPVerificationUsecase(sl())(
          email: myemail, otp: int.parse(otp.text));
      res.fold(
          (l) => Fluttertoast.showToast(
              msg: l.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0), (r) {
        otp.clear();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ResetPasswordscreen()));
      });
    }
  }

  Future<void> resetPassword(TextEditingController password,
      TextEditingController cpassword, BuildContext context) async {
    String message = '';
    final res = await ResetPasswordUsecase(sl())(
        password: password.text, email: myemail);
    res.fold((l) => message = l.message!, (r) {
      password.clear();
      cpassword.clear();
      message = "password_reset";
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool isNumeric(String number) {
    for (int i = 0; i < number.length; i++) {
      if (!'0123456789'.contains(number[i])) {
        return false;
      }
    }
    return true;
  }

  Future<void> updateProfile(
      {required TextEditingController firstName,
      required TextEditingController lastName,
      required String address,
      required TextEditingController phone,
      required id,
      required String gender,
      required String birthDate,
      required BuildContext context}) async {
    String message = '';
    final res = await UpdateUserUsecase(sl())(
        firstName: firstName.text,
        lastName: lastName.text,
        adresse: address,
        phone: phone.text,
        id: id,
        gender: gender,
        birthDate: DateTime.parse(birthDate));
    res.fold((l) => message = l.message!, (r) async {
      message = "profile_updated";
      await getCurrentUser(currentUser.id!);
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> getCurrentUser(String userId) async {
    final res = await GetUserByIdUsecase(sl())(userId: userId);
    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0), (r) {
      currentUser = r;
      gender = currentUser.gender;
      birthDate = currentUser.birthDate.toString();
    });
    update();
  }

  Future<void> updateImage(BuildContext context) async {
    try {
      if (f == null) {
        Fluttertoast.showToast(
          msg: "No image selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      if (userImage == '') {
        await ClearUserImageUsecase(sl())(currentUser.id!);
      } else {
        await UpdateImageUsecase(sl())(image: f!, userId: currentUser.id!);
      }

      await getCurrentUser(currentUser.id!).then((value) =>
          Fluttertoast.showToast(
              msg: "Profile picture updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0));
    } catch (e) {
      print('Error updating image: $e');
      Fluttertoast.showToast(
        msg: "Error updating image: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> updatePassword(TextEditingController currentPassword,
      TextEditingController password, BuildContext context) async {
    // Ensure currentUser is initialized first
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      await getCurrentUser(currentUser.id!); // Fetch current user if null
    }

    // Check if currentUser is still null after fetching
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      Fluttertoast.showToast(
          msg: "User data is not available. Please log in again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    String message = 'error';
    final res = await UpdatePasswordUsercase(sl())(
      userId: currentUser.id!,
      newPassword: password.text,
      oldPassword: currentPassword.text,
    );
    res.fold((l) => message = l.message!, (r) async {
      message = "profile_updated";
      password.clear();
      currentPassword.clear();
      await getCurrentUser(currentUser.id!);
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
