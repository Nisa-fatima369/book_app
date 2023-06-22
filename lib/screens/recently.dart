import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recently extends StatefulWidget {
  const Recently({super.key});

  @override
  State<Recently> createState() => _RecentlyState();
}

class _RecentlyState extends State<Recently> {
  // final List _gridItems = List.generate(90, (i) => "Item $i");
  List<Book> book = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Recently Added'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('books').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> books = snapshot.data!.docs
                .map((item) => Book.fromMap(item.data()))
                .toList();
            return CustomScrollView(
              slivers: [
                const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
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
                                Navigator.pushNamed(
                                    context, Routes.description);
                              },
                              child: Container(
                                height: size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.filledColor,
                                ),
                                child: Image.network(
                                  books[index].imageUrl ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
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

// class RecentlyAdded extends StatelessWidget {
//   RecentlyAdded({
//     this.onTap,
//     super.key,
//     required this.size,
//   });

//   final Size size;
//   Function? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.description);
//             },
//             child: Container(
//               height: size.height * 0.25,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               color: AppColors.filledColor,

//               ),
//                child: Image.network(
//                               books[index].imageUrl ?? '',
//                               fit: BoxFit.cover,
//                             ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.009),
//           Text(
//             'Book Name',
//             style: Theme.of(context).textTheme.labelLarge,
//           ),
//           SizedBox(height: size.height * 0.009),
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               'category',
//               style: Theme.of(context).textTheme.labelSmall,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
