import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Swap extends StatefulWidget {
  const Swap({super.key});

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;

    final List<String> tabs = <String>[
      'Buy',
      'Exchange',
      'Donate',
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: AppColors.selectedColor,
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      // right: 30,
                    ),
                    child: TextFormField(
                      controller: _controller,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.selectedColor),
                      decoration: kGreyTextField.copyWith(
                        filled: true,
                        hintText: 'search',
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.selectedColor),
                        suffixIcon: GestureDetector(
                          onTap: _controller.clear,
                          child: const Icon(
                            Icons.cancel_rounded,
                            color: AppColors.selectedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  toolbarHeight: 90,
                  collapsedHeight: 100,
                  pinned: true,
                  expandedHeight: 170.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    unselectedLabelColor: AppColors.secondary,
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('books')
                .where('purpose', isEqualTo: 'Buy')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Book> books = snapshot.data!.docs
                    .map((item) => Book.fromMap(item.data()))
                    .toList();
                return TabBarView(
                  children: tabs.map((String name) {
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            key: PageStorageKey<String>(name),
                            slivers: <Widget>[
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.all(0.0),
                                sliver: SliverFixedExtentList(
                                  itemExtent: 100.0,
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10, left: 10),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.description,
                                              );
                                            },
                                            leading: Container(
                                              height: 130,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: AppColors.selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            subtitle: Text(
                                              books[index].category ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            trailing: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                  }).toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
