import 'package:fit_bowl_2/data/modeles/supplement_model.dart';
import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/supplementusecase/get_supplementbyid_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SupplementController extends GetxController {
  SupplementModel? supplement;
  String errorMessage = '';

  Future<void> getSupplementById(String supplementId) async {
    final res = await GetSupplementByIdUseCase(sl())(supplementId);

    res.fold(
      (l) {
        Fluttertoast.showToast(
          msg: l.message ?? 'Failed to load supplement.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      (r) {
        supplement = r as SupplementModel?;
      },
    );
    update(); // Trigger UI update if needed
  }
}
