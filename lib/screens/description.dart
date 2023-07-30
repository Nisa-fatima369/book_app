import 'package:book_app/models/auth_data_model.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final Book book;
  const Description({super.key, required this.book, this.user});
  final AuthData? user;

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('books')
                  .where('id', isEqualTo: widget.book.id)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final map = snapshot.data.docs.first.data();
                  final book = Book.fromMap(map);
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final isBookMarked = (book.bookMarkedUsers ?? [])
                      .contains(FirebaseAuth.instance.currentUser!.uid);
                  return GestureDetector(
                    onTap: () async {
                      if (isBookMarked) {
                        await FirebaseFirestore.instance
                            .collection('books')
                            .doc(widget.book.id)
                            .update({
                          'bookMarkedUsers': FieldValue.arrayRemove([uid])
                        }).then((value) => setState(() {}));
                      } else {
                        await FirebaseFirestore.instance
                            .collection('books')
                            .doc(widget.book.id)
                            .update({
                          'bookMarkedUsers': FieldValue.arrayUnion([uid])
                        }).then((value) => setState(() {}));
                      }
                    },
                    child: isBookMarked
                        ? const Icon(
                            Icons.bookmark,
                            color: AppColors.primary,
                          )
                        : const Icon(
                            Icons.bookmark_outline,
                            color: AppColors.selectedColor,
                          ),
                  );
                }
                return const SizedBox();
              },
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
              color: Colors.black45,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.book.imageUrl!,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.book.userId)
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final map = snapshot.data!.data();
                        final user = AuthData.fromMap(map);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: user.profileUrl != null &&
                                      user.profileUrl!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.filledColor,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        user.profileUrl!,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: AppColors.filledColor,
                                      radius: 30,
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    ),
                            ),
                            SizedBox(width: size.width * 0.05),
                            Text(
                              user.fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Added on  ${widget.book.createdAt ?? ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text('Description',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    height: size.width * 0.33,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.filledColor,
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
                        hintText: widget.book.description ??
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text(
                        'Condition:',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Text(
                        widget.book.condition!,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.w500),
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
                        child: Text('Contact',
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
