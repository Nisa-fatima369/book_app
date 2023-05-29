import 'package:book_app/theme/color.dart';
import 'package:book_app/util/list_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:book_app/widgets/textfield.dart';
import 'package:book_app/config/routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? departmentvalue;
  String? semestervalue;
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
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
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomField(
                      hint: '****-GCUF-******',
                      controler: _regNoController,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomField(
                      hint: 'Nisa Fatima',
                      controler: _nameController,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Department',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: size.height * 0.005),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        style: Theme.of(context).textTheme.titleMedium,
                        isExpanded: true,
                        value: departmentvalue,
                        items: departmentlist
                            .map((dep) => DropdownMenuItem(
                                  value: dep,
                                  child: Text(
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    dep,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            departmentvalue = value.toString();
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: size.height * 0.06,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  color: AppColors.filledColor,
                                ),
                              ]),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: AppColors.filledColor,
                              ),
                            ],
                          ),
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            searchController.clear();
                          }
                        },
                      ),
                    ),

                    // ReuseTextFields(hintText: '', onTap: () {}, options: departmentlist,),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      'Semester',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: size.height * 0.005),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        style: Theme.of(context).textTheme.titleMedium,
                        isExpanded: true,
                        value: semestervalue,
                        items: semesterlist
                            .map((dep) => DropdownMenuItem(
                                  value: dep,
                                  child: Text(
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    dep,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            semestervalue = value.toString();
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: size.height * 0.06,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  color: AppColors.filledColor,
                                ),
                              ]),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: AppColors.filledColor,
                              ),
                            ],
                          ),
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        // onMenuStateChange: (isOpen) {
                        //   if (!isOpen) {
                        //     searchController.clear();
                        //   }
                        // },
                      ),
                    ),

                   
                    SizedBox(height: size.height * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                          width: size.width * 0.25,
                          child: TextButton(
                            onPressed: () {
                           
                              Navigator.pushNamed(context, Routes.pageVieew);
                            },
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: AppColors.primary,
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
