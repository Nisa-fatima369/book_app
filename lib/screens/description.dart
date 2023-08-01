import 'package:book_app/config/routes.dart';
import 'package:book_app/models/auth_data_model.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final Book book;
  const Description({
    super.key,
    required this.book,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  AuthData? user;
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
              future: FirebaseFirestore.instance.collection('books').where('id', isEqualTo: widget.book.id).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final map = snapshot.data.docs.first.data();
                  final book = Book.fromMap(map);
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final isBookMarked = (book.bookMarkedUsers ?? []).contains(FirebaseAuth.instance.currentUser!.uid);
                  return GestureDetector(
                    onTap: () async {
                      if (isBookMarked) {
                        await FirebaseFirestore.instance.collection('books').doc(widget.book.id).update({
                          'bookMarkedUsers': FieldValue.arrayRemove([uid])
                        }).then((value) => setState(() {}));
                      } else {
                        await FirebaseFirestore.instance.collection('books').doc(widget.book.id).update({
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
                  FutureBuilder(
                    future: FirebaseFirestore.instance.collection('users').doc(widget.book.userId).get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final map = snapshot.data!.data();
                        user = AuthData.fromMap(map);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: user?.profileUrl != null && user!.profileUrl!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.filledColor,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        user!.profileUrl!,
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
                              user!.fullName,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
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
                  Text('Description', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.book.description!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
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
                        widget.book.condition!,
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
                        onPressed: () async {
                          if (widget.book.userId == FirebaseAuth.instance.currentUser!.uid) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You can not contact yourself')));
                            return;
                          }

                          await FirebaseFirestore.instance
                              .collection('chatRooms')
                              .where(
                              
                                'participants',
                                arrayContainsAny: [ FirebaseAuth.instance.currentUser!.uid, widget.book.userId],
                              )
                               
                              .get()
                              .then((value) async {
                            if (value.docs.isNotEmpty) {
                              final map = value.docs.first.data();
                              final chatRoomId = value.docs.first.id;
                              Navigator.pushNamed(context, Routes.chat, arguments: [chatRoomId, widget.book.userId]);
                            } else {
                              DocumentReference chatRoomRef = FirebaseFirestore.instance.collection('chatRooms').doc();
                              await FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomRef.id).set({
                                'participants': [FirebaseAuth.instance.currentUser!.uid, widget.book.userId],
                                'sender': FirebaseAuth.instance.currentUser!.uid,
                                'receiver': widget.book.userId,
                                'receiverName': user!.fullName,
                                'receiverProfileUrl': user!.profileUrl,
                                'createdAt': DateTime.now().toIso8601String(),
                                'id': chatRoomRef.id,
                              }).then((value) async {
                                Navigator.pushNamed(context, Routes.chat, arguments: [chatRoomRef.id, widget.book.userId]);
                              });
                            }
                          });
                        },
                        child: Text('Contact', style: Theme.of(context).textTheme.labelSmall),
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
