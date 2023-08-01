import 'package:book_app/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  OtpFieldController otpController = OtpFieldController();
  String? pincode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int? _resendToken;

    void resendOTP(String phoneNumber) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user on Android devices that support automatic SMS verification
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user!;
          print(user.uid);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle code sent callback
          resendToken = resendToken;

          print('Code Sent: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
          print('Timeout: $verificationId');
        },
        forceResendingToken: _resendToken,
        timeout: Duration(seconds: 60),
      );
    }

    _submitOTP(otp) async {
      FirebaseAuth _auth = FirebaseAuth.instance;

      String smsCode = otp; // Replace with the user's input
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: smsCode,
        );

        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP'),
          ),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 32,
            color: AppColors.selectedColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   // width: 300,
                //   height: size.height * 0.1,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //   ),
                //   // child: Image.asset(
                //   //   '',                  ),
                // ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.titleMedium),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
              ],
            ),
          ),
          OTPTextField(
            otpFieldStyle: OtpFieldStyle(
              borderColor: AppColors.primary,
              // enabledBorderColor: AppColors.selectedColor,
            ),
            controller: otpController,
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 40,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17, color: AppColors.selectedColor),
            onChanged: (pin) {
              print("Changed: $pin");
            },
            onCompleted: (pin) {
              // _submitOTP(pin);
              setState(() {
                pincode = pin;
              });
              print("Completed: $pin");
            },
          ),
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _submitOTP(pincode);
                },
                child: const Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 16, color: AppColors.filledColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          const Text(
            "Didn't receive any code?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Resend New Code",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
