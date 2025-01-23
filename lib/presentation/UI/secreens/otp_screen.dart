import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final otpController = TextEditingController();
  final List<TextEditingController> digitControllers =
      List.generate(4, (index) => TextEditingController());

  TextEditingController getCombinedOTPController() {
    final combinedController = TextEditingController();
    combinedController.text =
        digitControllers.map((controller) => controller.text).join();
    return combinedController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6ED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Decorative Container for Title
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF125B3C),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(44),
                    bottomRight: Radius.circular(44),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      'Code verification',
                      style: TextStyle(
                          fontFamily: 'LilitaOne',
                          fontSize: 40,
                          color: const Color(0xFFADEBB3)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Check your email to see the verification code',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        controller: digitControllers[index],
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "0",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: () async {
                  final AuthenticationController controller = Get.find();
                  TextEditingController otpCode = getCombinedOTPController();
                  // ignore: avoid_print
                  print("Entered OTP: $otpCode");
                  await controller.verifyOTP(otpCode, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF125B3C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 7,
                ),
                child: const Text(
                  'verify',
                  style: TextStyle(
                    fontFamily: 'LilitaOne',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
