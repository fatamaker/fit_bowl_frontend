import 'dart:io';
import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';
import 'package:fit_bowl_2/domain/entities/user.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/login_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/logout_usecase.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/home_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/login_screen.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationController extends GetxController {
  late Token token;
  late String myemail; //Stores the user's email during password recovery.
  bool termsAccepted =
      false; //Tracks whether terms and conditions are accepted.
  bool isLoading =
      false; //Indicates whether an asynchronous operation is in progress.
  late User currentUser; //Represents the logged-in user's data.
  String userImage = '';

  File? f; // Converts the XFile into a File object for further processing.
  String? gender;
  String? birthDate;

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
      message = "Account created!";

      // await CreateWishListUsecase(sl())(userId: r);
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
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
      // await getOneUser(r.userId).then((value) async {
      //   final WishListController wishListController = Get.find();
      //   final CartController cartController = Get.find();
      //   // final CategoryController categorControlller = Get.find();
      //   final AuthenticationController authController = Get.find();
      //   await wishListController
      //       .getUserWishlist(authController.currentUser.id!);
      //   await cartController.getUserCart(authController.currentUser.id!);
      //
      // });
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
}
