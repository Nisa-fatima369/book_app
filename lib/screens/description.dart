import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final Book book;
  const Description({required this.book}) : super();

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  void initState() {
    updateLastViewed();

    super.initState();
  }

  updateLastViewed() async {
    await FirebaseFirestore.instance
        .collection('LastViewed')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(
          widget.book.id,
        )
        .set(
      {
        'last_viewed': DateTime.now(),
        'book_id': widget.book.id,
      },
    );
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
          title: const Text('Book Details'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.bookmark,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.title ?? '',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'by ${widget.book.author ?? ''}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: AppColors.filledColor,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.book.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent.withOpacity(0.3),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              'Nisa Fatima',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Added on  ${widget.book.createdAt ?? ''}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text('Description', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      height: size.width * 0.33,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: AppColors.filledColor, blurRadius: 1, spreadRadius: 2),
                        ],
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                        maxLines: null,
                        maxLength: null,
                        expands: true,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        decoration: kGreyTextField.copyWith(
                          hintMaxLines: null,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          hintText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Text(
                          'Condition:',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: size.width * 0.04),
                        Text(
                          'As new good condition',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Contact', style: Theme.of(context).textTheme.labelSmall),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
