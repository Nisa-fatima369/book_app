import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// class PhoneScreen extends StatefulWidget {
//    PhoneScreen({super.key, });

//   static String? verificationId;

//   @override
//   State<PhoneScreen> createState() => _PhoneScreenState();
// }

// class _PhoneScreenState extends State<PhoneScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController phoneController = TextEditingController();

//   String initialCountry = 'PK';
//   PhoneNumber number = PhoneNumber(isoCode: 'PK');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
// Text(
//   'Register Phone Number',
//   style: Theme.of(context).textTheme.headlineSmall,
//   textAlign: TextAlign.center,
// ),
// SizedBox(height: 10),
// Text(
//   "Add your phone number. we'll send you a verification code so we know you're real",
//   style: Theme.of(context)
//       .textTheme
//       .titleMedium!
//       .copyWith(color: AppColors.titleMedium),
//   textAlign: TextAlign.center,
// ),
// SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 24),
//                       child: Form(
//                         key: formKey,
//                         child: InternationalPhoneNumberInput(
//                           onInputChanged: (PhoneNumber number) {
//                             this.number = number;
//                           },
//                           onInputValidated: (bool value) {},
//                           selectorConfig: const SelectorConfig(
//                             selectorType: PhoneInputSelectorType.DIALOG,
//                           ),
//                           ignoreBlank: false,
//                           autoValidateMode: AutovalidateMode.onUserInteraction,
//                           selectorTextStyle:
//                               const TextStyle(color: Colors.black),
//                           spaceBetweenSelectorAndTextField: 0,
//                           initialValue: number,
//                           textFieldController: phoneController,
//                           formatInput: true,
//                           keyboardType: const TextInputType.numberWithOptions(
//                               signed: true, decimal: true),
//                           inputBorder: InputBorder.none,
//                           onSaved: (PhoneNumber number) {},
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       spreadRadius: 1,
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 width: double.infinity,
//                 child: TextButton(
//                   onPressed: () async {
//                     FirebaseAuth auth = FirebaseAuth.instance;
//                     if (formKey.currentState?.validate() ?? false) {
//                       await FirebaseAuth.instance.verifyPhoneNumber(
//                         phoneNumber: number.phoneNumber!,
//                         timeout: const Duration(seconds: 60),
//                         verificationCompleted:
//                             (PhoneAuthCredential credential) async {
//                           await auth.signInWithCredential(credential).then(
//                                 (value) => Navigator.pushReplacementNamed(
//                                     context, Routes.otp),
//                               );
//                         },
//                         verificationFailed: (FirebaseAuthException e) {
//                           print(e.message);
//                         },
//                         codeSent: (String verificationId, int? resendToken) {
//                           Navigator.pushNamed(context, Routes.otp,
//                               arguments: verificationId);
//                         },
//                         codeAutoRetrievalTimeout: (String verificationId) {
//                           print(verificationId);
//                         },
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a valid phone number'),
//                         ),
//                       );
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.onSecondary),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phonecontroller = TextEditingController();
  String? countrycode;
  Future<void> sendOTP(String phoneNumber) async {
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
      codeSent: (String verificationId, [int? resendToken]) {
        // Handle code sent callback
        // You can save the verification ID for later use
        print('Code Sent: $verificationId');
        Navigator.pushReplacementNamed(
          context,
          Routes.otp,
          arguments: verificationId,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout
        // You can save the verification ID for later use
        print('Timeout: $verificationId');
      },
      timeout: Duration(
        seconds: 60,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.28),
            Text(
              'Register Phone Number',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
            Text(
              "Add your phone number. we'll send you a verification code so we know you're real",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.titleMedium),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            IntlPhoneField(
              initialCountryCode: "PK",
              dropdownTextStyle: Theme.of(context).textTheme.labelMedium,
              controller: phonecontroller,
              style: Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.labelMedium,
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0.0,
                    color: AppColors.filledColor,
                  ),
                ),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
                setState(() {
                  countrycode = phone.countryCode;
                });
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: size.width * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    // _loginWithPhoneNumber(phonecontroller.text);

                    String phoneno = countrycode! + phonecontroller.text;
                    sendOTP(phoneno);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.filledColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
