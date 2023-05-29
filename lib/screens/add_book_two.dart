import 'dart:io';

import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookContinue extends StatefulWidget {
  const AddBookContinue({super.key});

  @override
  State<AddBookContinue> createState() => _AddBookContinueState();
}

class _AddBookContinueState extends State<AddBookContinue> {
  @override
  Widget build(BuildContext context) {

    // File? pickedImage;
    // bool isPicked = false;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
        ),
        title: Text(
          'Add A Book',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In order to give a seond home to your books, please give us many details about it as possible.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Add Photo',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Stack(
                children: [
                  InkWell(
                    //     onTap: () async {
                    //   final ImagePicker _picker = ImagePicker();
                    //   final XFile? image =
                    //       await _picker.pickImage(source: ImageSource.gallery);
                    //   if (image != null) {
                    //     pickedImage = File(image.path);
                    //     setState(() {
                    //       isPicked = true;
                    //     });
                    //   }
                    // },
                    child: Container(
                      height: size.width * 0.45,
                      decoration: BoxDecoration(
                        color: AppColors.filledColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.filledColor,
                              blurRadius: 1,
                              spreadRadius: 2),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 140,
                    height: 40,
                    width: 40,
                    child: Icon(Icons.add_circle_outline_rounded),
                  ),
                  Positioned(
                    top: 85,
                    left: 60,
                    child: Text(
                      'Add Photos Of Your Books',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Write a Short Description',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                height: size.width * 0.35,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1,
                        spreadRadius: 2),
                  ],
                ),
                child: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                  maxLines: null,
                  maxLength: null,
                  expands: true,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  decoration: kGreyTextField.copyWith(
                    hintMaxLines: null,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    hintText: 'Write a brief description about book.',
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.4,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Publish',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
