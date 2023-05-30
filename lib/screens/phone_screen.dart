import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneScreen extends StatefulWidget {
   const PhoneScreen({super.key});

  static String actualCode='';


  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();


  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register Phone Number',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add your phone number. we'll send you a verification code so we know you're real",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.titleMedium),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Form(
                        key: formKey,
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            this.number = number;
                          },
                          onInputValidated: (bool value) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          spaceBetweenSelectorAndTextField: 0,
                          initialValue: number,
                          textFieldController: phoneController,
                          formatInput: true,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: InputBorder.none,
                          onSaved: (PhoneNumber number) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: number.phoneNumber!,
                        timeout: const Duration(seconds: 60),
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          print(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          print(e);
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          
                         
                          Navigator.pushNamed(context, Routes.otp,arguments: verificationId);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          
                          print(verificationId);
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid phone number'),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
