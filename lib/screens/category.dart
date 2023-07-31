import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categorry extends StatelessWidget {
  const Categorry({super.key, this.categoory});

  final String? categoory;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(categoory.toString()),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('books').where('category', isEqualTo: categoory).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> books = snapshot.data!.docs.map((item) => Book.fromMap(item.data())).toList();
            return CustomScrollView(
              slivers: [
                const SliverPadding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.description, arguments: books[index]);
                              },
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: size.height * 0.25,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.filledColor,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: books[index].imageUrl ?? '',
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )),
                            ),
                            SizedBox(height: size.height * 0.009),
                            Text(
                              books[index].title ?? '',
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: size.height * 0.009),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                books[index].category ?? '',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: books.length,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
