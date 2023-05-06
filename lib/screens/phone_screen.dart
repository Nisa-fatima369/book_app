import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:book_app/routes.dart';
import 'package:flutter/services.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

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
                  child: Image.asset(
                    'image/illustration-3.png',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  'Register Phone Number',
                  style: Theme.of(context).textTheme.headlineSmall,
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
                          // PakistaniPhoneNumberFormatter(),
                        ],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          // labelText: 'Phone Number',
                          hintText: 'e.g. 03xx-xxxxxxx',
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
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.otp);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Continue',
                              style: TextStyle(fontSize: 16),
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

// Parsing
// +1 (417) 555-5470

String? validateMobile(String value) {
  // Pattern pattern =
  //     r'^(?:(?:(?:\+|00)92)-|0)3[0-6]\d-\d{7}$';
  RegExp regex = RegExp(r'^(?:(?:(?:\+|00)92)-|0)3[0-6]\d-\d{7}$');
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else {
    return null;
  }
}

class PhoneNumberField extends StatefulWidget {
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        // PakistaniPhoneNumberFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'e.g. 03xx-xxxxxxx',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a phone number';
        }
        return null;
      },
    );
  }
}

// class PakistaniPhoneNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final text = newValue.text;
//     var newText = '';
//     var selectionIndex = newValue.selection.end;

//     if (text.isNotEmpty) {
//       // Add the first three characters (i.e. the area code)
//       newText += text.substring(0, 3);
//       if (text.length > 3) {
//         // Add a dash after the area code
//         newText += '-';
//         if (selectionIndex > 3) {
//           selectionIndex++;
//         }

//         // Add the next 7 characters (i.e. the phone number)
//         if (text.length > 3 && text.length <= 10) {
//           newText += text.substring(3);
//         } else if (text.length > 10) {
//           newText += text.substring(3, 10) + '-';
//           if (selectionIndex > 10) {
//             selectionIndex++;
//           }
//           newText += text.substring(10);
//         }
//       }
//     }

//     return TextEditingValue(
//       text: newText,
//       selection: TextSelection.collapsed(offset: selectionIndex),
//     );
//   }
// }






// // Parsing
// String springFieldUSA = '+1-417-555-5470';
// PhoneNumber phoneNumber = await PhoneNumberUtil().parse(springFieldUSA);

// // Validate
// bool isValid = await PhoneNumberUtil().validate(springFieldUSA);

// // Format
// String formatted = await PhoneNumberUtil().format(springFieldUSASimpleNoRegion, region.code); // +1 (417) 555-5470

// PhoneNumber{
//   e164: +14175555470,
//   type: PhoneNumberType.FIXED_LINE_OR_MOBILE,
//   international: +1 417-555-5470,
//   national: (417) 555-5470,
//   countryCode: 1,
//   regionCode: "US",
//   nationalNumber: 4175555470,
//   errorCode: null,
// }

// String springFieldUSASimple = '+14175555470';
// PhoneNumber phoneNumber = await PhoneNumberUtil().parse(springFieldUSASimple);
// phoneNumber.regionCode; // US