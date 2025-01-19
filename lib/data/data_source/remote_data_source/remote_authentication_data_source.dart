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
}
