import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/reuse_textfield.dart';
import 'package:flutter/material.dart';
import 'package:book_app/widgets/textfield.dart';
import 'package:book_app/routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _regNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Text(
                  'REGISTRATION FORM',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: size.height * 0.07),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registration No.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomField(
                      hint: '****-GCUF-******',
                      controler: _regNoController,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomField(
                      hint: 'Nisa Fatima',
                      controler: _regNoController,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Department',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    ReuseTextFields(hintText: '', onTap: () {}),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Semester',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    ReuseTextFields(hintText: '', onTap: () {}),
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: size.width * 0.25,
                          child: TextButton(
                            onPressed: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return HomeScreen();
                              //     },
                              //   ),
                              // );
                              Navigator.pushNamed(context, Routes.homeScreen);
                            },
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateProperty.all(
                            //       AppColors.selectedColor),
                            //   shape: MaterialStateProperty.all<
                            //       RoundedRectangleBorder>(
                            //     RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12.0)),
                            //   ),
                            // ),
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_optionBottomSheet(BuildContext context, List<String> options,
    TextEditingController controller) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) {
      return ListView.separated(
        itemCount: 14,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              controller.text = options[index];
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(
                options[index],
              ),
            ),
          );
        },
      );
    },
  );
}
