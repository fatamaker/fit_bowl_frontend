// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/utils/api_const.dart';

import 'package:fit_bowl_2/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:fit_bowl_2/data/modeles/token_model.dart';
import 'package:http/http.dart' as http;

import 'package:fit_bowl_2/data/modeles/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createAccount(
    String firstName,
    String lastName,
    String imageUrl,
    String email,
    String adresse,
    String phone,
    String gender,
    DateTime birthDate,
    String password,
  );
  Future<TokenModel> login(String email, String password);
  Future<TokenModel> autoLogin();

  Future<void> forgetPassword(
      {required String email, required String destination});
  Future<void> verifyOTP(String email, int otp);
  Future<void> resetPassword(String email, String password);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  Future<TokenModel> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  @override
  Future<void> createAccount(
      String firstName,
      String lastName,
      String imageUrl,
      String email,
      String adresse,
      String phone,
      String gender,
      DateTime birthDate,
      String password) async {
    try {
      // Create the user model
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          imageUrl: "",
          email: email,
          address: adresse,
          phone: "",
          gender: "",
          //birthDate: "",
          password: password);
      Map<String, dynamic> requestData = userModel.toJson();
      // Parse the URL
      final url = Uri.parse("http://192.168.1.13:5000/api/register");
      print(requestData.toString());
      print("test");
      // Make the POST request
      final response = await http.post(url, body: userModel.toJson());
      print("test testt");
      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData["uId"];
      } else if (response.statusCode == 403) {
        throw RegistrationException("email_already_used");
      } else {
        throw ServerException(
            message: "Unexpected error occurred: ${response.body}");
      }
    } catch (e) {
      // Re-throw the caught error for further handling
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<TokenModel> login(String email, String password) async {
    String msg = "";
    try {
      Map<String, dynamic> user = {'email': email, 'password': password};
      final url = Uri.parse(APIConst.login);
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final TokenModel token = TokenModel.fromJson(data);
        return token;
      } else {
        switch (res.statusCode) {
          case 202:
            msg = "wrong password";
            break;
          case 404:
            msg = "email not registred";

            break;
          default:
        }
        throw LoginException(msg);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<TokenModel> autoLogin() async {
    try {
      return await token;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword({
    required String email,
    required String destination,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(APIConst.forgetPassword),
        body: jsonEncode({"email": email, "destination": destination}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 404) {
        throw DataNotFoundException("email not registred");
      } else if (response.statusCode == 500) {
        throw ServerException(message: "server error");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(APIConst.resetPassword),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 404) {
        throw DataNotFoundException("email not registred");
      } else if (response.statusCode == 500) {
        throw ServerException(message: "error");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP(String email, int otp) async {
    try {
      final response = await http.post(
        Uri.parse(APIConst.verfifCode),
        body: jsonEncode({"email": email, "otp": otp}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 404) {
        throw BadOTPException("code invalid");
      } else if (response.statusCode == 400) {
        throw BadOTPException("expired code");
      }
    } catch (e) {
      rethrow;
    }
  }
}
