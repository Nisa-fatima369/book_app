import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FutureBuilder<QuerySnapshot<Map<String, dynamic>>> buy_method() {
  return FutureBuilder(
      future: FirebaseFirestore.instance.collection('books').where('purpose', isEqualTo: 'Sale').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Book> books = snapshot.data!.docs.map((item) => Book.fromMap(item.data())).toList();
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  // key: PageStorageKey<String>(),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 100.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.filledColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.filledColor,
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 10),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.description,
                                      arguments: books[index],
                                    );
                                  },
                                  leading: Container(
                                    height: 130,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.selectedColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Image.network(
                                      books[index].imageUrl ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    books[index].title ?? '',
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    books[index].category ?? '',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.bookmark,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: books.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

FutureBuilder<QuerySnapshot<Map<String, dynamic>>> exchange_method() {
  return FutureBuilder(
      future: FirebaseFirestore.instance.collection('books').where('purpose', isEqualTo: 'Exchange').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Book> books = snapshot.data!.docs.map((item) => Book.fromMap(item.data())).toList();
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  // key: PageStorageKey<String>(),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 100.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.filledColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.filledColor,
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 10),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.description,
                                      arguments: books[index],
                                    );
                                  },
                                  leading: Container(
                                    height: 130,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.selectedColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Image.network(
                                      books[index].imageUrl ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    books[index].title ?? '',
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    books[index].category ?? '',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.bookmark,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: books.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

FutureBuilder<QuerySnapshot<Map<String, dynamic>>> donate_method() {
  return FutureBuilder(
      future: FirebaseFirestore.instance.collection('books').where('purpose', isEqualTo: 'Donate').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Book> books = snapshot.data!.docs.map((item) => Book.fromMap(item.data())).toList();
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  // key: PageStorageKey<String>(),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 100.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.filledColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.filledColor,
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 10),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.description,
                                      arguments: books[index],
                                    );
                                  },
                                  leading: Container(
                                    height: 130,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.selectedColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Image.network(
                                      books[index].imageUrl ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    books[index].title ?? '',
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    books[index].category ?? '',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.bookmark,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: books.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}
