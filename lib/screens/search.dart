import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/screens/description.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_app/widgets/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  String title = '';
  // List book = List.generate(
  //     26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  Future<QuerySnapshot> fetchBooks =
      FirebaseFirestore.instance.collection('books').orderBy('title').get();
  List<Book> filtered = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: fetchBooks,
          builder: (context, snapshots) {
            if ((snapshots.connectionState == ConnectionState.waiting)) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Book> books = snapshots.data!.docs
                  .map(
                    (item) => Book.fromMap(item.data() as Map<String, dynamic>),
                  )
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(15).copyWith(bottom: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            filtered = [];
                            return;
                          }
                          final query = value.toLowerCase();
                          filtered = (books).where((book) {
                            final bookTitle =
                                book.title!.toLowerCase().contains(query);
                            return bookTitle;
                          }).toList(growable: false)
                            ..sort(
                              (a, b) => a.title!
                                  .toLowerCase()
                                  .indexOf(query)
                                  .compareTo(
                                    b.title!.toLowerCase().indexOf(query),
                                  ),
                            );
                        });
                      },
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.selectedColor),
                      decoration: kGreyTextField.copyWith(
                        filled: true,
                        hintText: 'search',
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.selectedColor),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.isNotEmpty
                            ? filtered.length
                            : snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final book = filtered.isNotEmpty
                              ? filtered[index]
                              : books[index];
                          if (title.isEmpty) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Description(
                                        book: book,
                                      );
                                    },
                                  ),
                                );
                              },
                              title: Text(
                                book.title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


// SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: TextFormField(
                //         controller: _controller,
                //         onChanged: (query) {
                //           searchData(query);
                //         },
                //         style: const TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: AppColors.selectedColor),
                //         decoration: kGreyTextField.copyWith(
                //           filled: true,
                //           hintText: 'search',
                //           prefixIcon: const Icon(Icons.search,
                //               color: AppColors.selectedColor),
                //           suffixIcon: GestureDetector(
                //             onTap: _controller.clear,
                //             child: const Icon(
                //               Icons.cancel_rounded,
                //               color: AppColors.selectedColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.of(context)
                //             .pushReplacementNamed(Routes.pageVieew);
                //       },
                //       child: Text(
                //         'cancel',
                //         style: Theme.of(context)
                //             .textTheme
                //             .labelSmall!
                //             .copyWith(fontSize: 18),
                //       ),
                //     ),
                //   ],
                // ),
//                 SizedBox(height: size.height * 0.05),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Books',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelLarge!
//                           .copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'see all',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelSmall!
//                           .copyWith(fontSize: 18),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.05),
//                 SizedBox(
//                   height: size.height *0.45,
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: searchResult.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         title: Text(searchResult[index]['title']),
//                       );
//                     },
//                   ),
//                 ),
//                 // Text('Atmoic Books',
//                 //     ),

//                 SizedBox(height: size.height * 0.03),
//                 const Divider(color: AppColors.selectedColor),
//                 SizedBox(height: size.height * 0.03),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Recent Searches',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelLarge!
//                           .copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Text(
//                         'Delete history',
//                         style: Theme.of(context)
//                             .textTheme
//                             .labelSmall!
//                             .copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.04),
//                 Text('The beast',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 Text('Dark French',
//                     style: Theme.of(context).textTheme.titleMedium),
//               ],
//             ),
//           ),
//         ),
//       ),