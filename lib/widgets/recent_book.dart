import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentlyAdded extends StatelessWidget {
  const RecentlyAdded({
    super.key,
    required this.height,
    required this.width,
    this.onTap,
  });

  final double height;
  final double width;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('books').orderBy('createdAt', descending: true).limit(10).snapshots(),
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
                      Navigator.pushNamed(context, Routes.description, arguments: books[index]);
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
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: books[index].imageUrl ?? '',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        SizedBox(
                          width: width * 0.27,
                          child: Text(
                            books[index].title ?? '',
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox(
          height: 80,
          width: 90,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
