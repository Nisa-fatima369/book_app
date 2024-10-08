import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/util/list_utils.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
// import 'dart:math' as math;

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add A Book',
        ),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconSize: 30,
          iconColor: AppColors.primary,
          useInkWell: true,
          expandIcon: Icons.arrow_drop_down,
          collapseIcon: Icons.arrow_drop_up,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'In order to give a seond home to your books, please give us many details about it as possible.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Card1(),
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  const Card1({super.key});

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerAuthor = TextEditingController();
  TextEditingController controllerYear = TextEditingController();
  String? categorry;
  String? purpose;
  String? condition;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.filledColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScrollOnExpand(
                scrollOnCollapse: false,
                scrollOnExpand: false,
                child: ExpandablePanel(
                  header: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Add Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                      right: 25,
                      left: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book Title',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        SizedBox(
                          height: size.height * 0.05,
                          child: TextFormField(
                            controller: controllerTitle,
                            style: Theme.of(context).textTheme.labelLarge,
                            decoration: kWhiteTextField.copyWith(
                              hintText: 'Book title',
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Author',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        SizedBox(
                          height: size.height * 0.05,
                          child: TextFormField(
                            controller: controllerAuthor,
                            style: Theme.of(context).textTheme.labelLarge,
                            decoration:
                                kWhiteTextField.copyWith(hintText: 'Author'),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Year Of Publishing',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        SizedBox(
                          height: size.height * 0.05,
                          child: TextFormField(
                            controller: controllerYear,
                            style: Theme.of(context).textTheme.labelLarge,
                            decoration:
                                kWhiteTextField.copyWith(hintText: 'Year'),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Category',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            style: Theme.of(context).textTheme.labelLarge,
                            isExpanded: true,
                            value: categorry,
                            items: options
                                .map((categorry) => DropdownMenuItem(
                                      value: categorry,
                                      child: Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        categorry,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                categorry = value.toString();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: size.height * 0.05,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: AppColors.secondary,
                                    ),
                                  ]),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: AppColors.secondary,
                                  ),
                                ],
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Purpose of book',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            style: Theme.of(context).textTheme.labelLarge,
                            isExpanded: true,
                            value: purpose,
                            items: purposes
                                .map((purpose) => DropdownMenuItem(
                                      value: purpose,
                                      child: Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        purpose,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                purpose = value.toString();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: size.height * 0.05,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: AppColors.secondary,
                                    ),
                                  ]),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: AppColors.secondary,
                                  ),
                                ],
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'condition of book',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            style: Theme.of(context).textTheme.labelLarge,
                            isExpanded: true,
                            value: condition,
                            items: bookConition
                                .map((condition) => DropdownMenuItem(
                                      value: condition,
                                      child: Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        condition,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                condition = value.toString();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: size.height * 0.05,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: AppColors.secondary,
                                    ),
                                  ]),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 2,
                                    color: AppColors.secondary,
                                  ),
                                ],
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.4,
                            child: TextButton(
                              onPressed: () async {
                                DocumentReference docRef =
                                    await FirebaseFirestore.instance
                                        .collection('books')
                                        .doc();
                                Navigator.pushNamed(
                                  context,
                                  Routes.addBookCon,
                                  arguments: Book(
                                    id: docRef.id,
                                    title: controllerTitle.text,
                                    author: controllerAuthor.text,
                                    year: controllerYear.text,
                                    category: categorry,
                                    purpose: purpose,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    condition: condition,    
                                  ),
                                );
                              },
                              child: Text(
                                'Continue',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
