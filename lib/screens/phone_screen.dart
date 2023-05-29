import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  static String verify = '';

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  // child: Image.asset(
                  //   '',
                  // ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  'Register Phone Number',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.titleMedium),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: kGreyTextField.copyWith(
                          labelText: 'Phone Number',
                          // hintText: 'e.g. 03xx-xxxxxxx',
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // PhoneNumberField(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '0300 1234567',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                PhoneScreen.verify = verificationId;
                                Navigator.pushNamed(context, Routes.otp);
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isValidPhoneNumber(String string) {
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

// String? validateMobile(String value) {
//   // Pattern pattern =
//   //     r'^(?:(?:(?:\+|00)92)-|0)3[0-6]\d-\d{7}$';
//   RegExp regex = RegExp(r'^(?:(?:(?:\+|00)92)-|0)3[0-6]\d-\d{7}$');
//   if (!regex.hasMatch(value))
//     return 'Enter Valid Email';
//   else {
//     return null;
//   }
// }

// class PhoneNumberField extends StatefulWidget {
//   @override
//   _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
// }

// class _PhoneNumberFieldState extends State<PhoneNumberField> {
//   final _phoneController = TextEditingController();

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: _phoneController,
//       keyboardType: TextInputType.phone,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         // PakistaniPhoneNumberFormatter(),
//       ],
//       decoration: InputDecoration(
//         labelText: 'Phone Number',
//         // hintText: 'e.g. 03xx-xxxxxxx',
//       ),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter a phone number';
//         }
//         return null;
//       },
//     );
//   }
// }
