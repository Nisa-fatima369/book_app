import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LastViewed extends StatefulWidget {
  const LastViewed({
    super.key,
    required this.height,
    required this.width,
    this.onTap,
  });

  final double height;
  final double width;
  final Function? onTap;

  @override
  State<LastViewed> createState() => _LastViewedState();
}

class _LastViewedState extends State<LastViewed> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('LastViewed').doc(FirebaseAuth.instance.currentUser!.uid).collection('books').snapshots(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List lastViewed = snapShot.data!.docs.map((e) => e.data()).toList();
          lastViewed.sort((a, b) => b['last_viewed'].compareTo(a['last_viewed']));

          return Container(
            height: widget.height * 0.28,
            child: ListView.builder(
              itemCount: lastViewed.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                    future: FirebaseFirestore.instance.collection('books').doc(lastViewed[index]['book_id']).get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: widget.height * 0.19,
                          width: widget.width * 0.27,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      Book book = Book.fromMap(snapshot.data!.data()!);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.description, arguments: book);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.filledColor,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  height: widget.height * 0.19,
                                  width: widget.width * 0.27,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: book.imageUrl ?? '',
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(height: widget.height * 0.005),
                              SizedBox(
                                width: widget.width * 0.27,
                                child: Text(
                                  book.title ?? '',
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
