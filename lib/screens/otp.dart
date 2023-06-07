import 'package:book_app/screens/phone_screen.dart';
import 'package:book_app/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_app/config/routes.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

// class Otp extends StatefulWidget {
//   const Otp({Key? key}) : super(key: key);

//   @override
//   _OtpState createState() => _OtpState();
// }

// class _OtpState extends State<Otp> {
//   TextEditingController smsCodeController = TextEditingController();

//   static var code = '';
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: SafeArea(
// child: Padding(
//   padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//   child: Column(
//     children: [
// Align(
//   alignment: Alignment.topLeft,
//   child: GestureDetector(
//     onTap: () => Navigator.pop(context),
//     child: Icon(
//       Icons.arrow_back,
//       size: 32,
//       color: AppColors.selectedColor,
//     ),
//   ),
// ),
// SizedBox(
//   height: 18,
// ),
// Container(
//   width: 300,
//   height: size.height * 0.25,
//   decoration: BoxDecoration(
//     shape: BoxShape.rectangle,
//   ),
//   // child: Image.asset(
//   //   '',                  ),
// ),
// SizedBox(
//   height: 24,
// ),
// Text(
//   'Verification',
//   style: TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.bold,
//   ),
// ),
// SizedBox(
//   height: 10,
// ),
// Text(
//   "Enter your OTP code number",
//   style: TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//     color: Colors.black38,
//   ),
//   textAlign: TextAlign.center,
// ),
// SizedBox(
//   height: 28,
// ),
//                 Container(
//                   padding: EdgeInsets.all(28),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _textFieldOTP(first: true, last: false),
//                           _textFieldOTP(first: false, last: false),
//                           _textFieldOTP(first: false, last: false),
//                           _textFieldOTP(first: false, last: false),
//                           _textFieldOTP(first: false, last: false),
//                           _textFieldOTP(first: false, last: true),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 22,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           boxShadow: [
//                             BoxShadow(
//                               spreadRadius: 1,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         width: double.infinity,
//                         child: TextButton(
//                           onPressed: () async {
//                             try {
//                               PhoneAuthCredential credential =
//                                   PhoneAuthProvider.credential(
//                                 verificationId:
//                                     PhoneScreen.verificationId.toString(),
//                                 smsCode: smsCodeController.text,
//                               );

//                               await auth.signInWithCredential(credential).then(
//                                     (value) => Navigator.pushReplacementNamed(
//                                         context, Routes.register),
//                                   );
//                             } catch (e) {
//                               print(e.toString());
//                             }
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(14.0),
//                             child: Text(
//                               'Verify',
//                               style: TextStyle(
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
// Text(
//   "Didn't you receive any code?",
//   style: TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//     color: Colors.black38,
//   ),
//   textAlign: TextAlign.center,
// ),
// SizedBox(
//   height: 18,
// ),
// Text(
//   "Resend New Code",
//   style: Theme.of(context).textTheme.labelSmall,
// ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _textFieldOTP({bool? first, last}) {
//     return SizedBox(
//       height: 85,
//       width: 45,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.length == 0 && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//             //  code = value;
//           },
//           showCursor: false,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: Offstage(),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(width: 2, color: AppColors.selectedColor),
//                 borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

    Future<void> _submitOTP(otp) async {
      FirebaseAuth _auth = FirebaseAuth.instance;

      String smsCode = otp; // Replace with the user's input
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: smsCode,
        );
        User? userr = FirebaseAuth.instance.currentUser;
        if (userr == null) {
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user!;
          Navigator.of(context).pushReplacementNamed(Routes.register);
          print("new user created");
        } else {
          Navigator.pushReplacementNamed(context, Routes.register);
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
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
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.titleMedium),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
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
            style:
                const TextStyle(fontSize: 17, color: AppColors.selectedColor),
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
          SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: size.width * 0.3,
              child: ElevatedButton(
                onPressed: () {
                  _submitOTP(pincode);
                },
                child: const Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Text(
                    'Confirm',
                    style:
                        TextStyle(fontSize: 16, color: AppColors.filledColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            "Didn't receive any code?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              // resendOTP('');
            },
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
