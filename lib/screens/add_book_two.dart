import 'dart:io';

import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/book_models.dart';

class AddBookContinue extends StatefulWidget {
  final Book book;
  const AddBookContinue({Key? key, required this.book}) : super(key: key);

  @override
  State<AddBookContinue> createState() => _AddBookContinueState();
}

class _AddBookContinueState extends State<AddBookContinue> {
  TextEditingController descritionController = TextEditingController();
  File? image;

  Future<File?> pickImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
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
                'In order to give a second home to your books, please give us many details about it as possible.',
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.filledColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1,
                        spreadRadius: 2),
                  ],
                ),
                height: size.width * 0.4,
                width: size.width,
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.contain,
                      )
                    : InkWell(
                        onTap: () => pickImage(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.add),
                            ),
                            Text(
                              'Add Photo',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
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
                  controller: descritionController,
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
                    onPressed: () async {
                      Navigator.popAndPushNamed(context, Routes.pageVieew);
                      UploadTask uploadTask = FirebaseStorage.instance
                          .ref()
                          .child('books/${widget.book.title}')
                          .putFile(image!);
                      uploadTask.snapshotEvents.listen((event) {
                        if (event.state == TaskState.success) {
                          event.ref.getDownloadURL().then((url) async {
                            await FirebaseFirestore.instance
                                .collection('books')
                                .doc()
                                .set(widget.book
                                    .copyWith(
                                        description: descritionController.text,
                                        imageUrl: url)
                                    .toMap());
                          });
                        }
                      });
                    },
                    child: Text(
                      'Post',
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
