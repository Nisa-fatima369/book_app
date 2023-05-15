import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/list_utils.dart';
import 'package:book_app/widgets/reuse_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:book_app/widgets/textfield.dart';
import 'package:book_app/routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   String? departmentvalue;
    String? semestervalue;
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

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
  DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
        
                        isExpanded: true,
                       
                        
                     
                        value: departmentvalue,
                           items: departmentlist
                            .map((dep) => DropdownMenuItem(
                                  value: dep,
                                  child: Text(
                                    dep,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            departmentvalue = value.toString();
                          });
                        },
                        buttonStyleData:  ButtonStyleData(
                         
                          height: 40,
                          width: size.width*09,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: searchController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: searchController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (departmentlist, searchValue) {
                            return (departmentlist.value
                                .toString()
                                .toLowerCase()
                                .contains(searchValue.toLowerCase()));
                          },
                        ),
                        //This to clear the search value when you close the menu
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,

                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      //             decoration: InputDecoration(  contentPadding: EdgeInsets.symmetric(
                      //   horizontal: 10.0,
                      //   vertical: 3.0,
                      // ),),
                      hint: Text(""),
                      validator: (value) {
                        if (value == null) {
                          return 'required';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      iconEnabledColor: Theme.of(context).primaryColor,
                      elevation: 16,

                      isDense: false,
                      alignment: AlignmentDirectional.topEnd,
                      value: semestervalue,
                      items: semesterlist.map((sem) {
                        return DropdownMenuItem(
                          value: sem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(sem.toString()),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          semestervalue = newValue.toString();
                        });
                      },
                    ),
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
                              Navigator.pushNamed(context, Routes.pageVieew);
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
              controller.text = departmentlist[index];
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(
                departmentlist[index],
              ),
            ),
          );
        },
      );
    },
  );
}
