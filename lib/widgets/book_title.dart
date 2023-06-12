import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BookWithTitle extends StatelessWidget {
  BookWithTitle({
    super.key,
    required this.height,
    required this.width,
    this.onTap,
  });

  final double height;
  final double width;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('books').get(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Book> books = snapShot.data!.docs.map((item) => Book.fromMap(item.data())).toList();
            return Container(
              height: height * 0.28,
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.description);
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
                              height: height * 0.19,
                              width: width * 0.27,
                              child: Image.network(
                                books[index].imageUrl ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            books[index].title ?? '',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
