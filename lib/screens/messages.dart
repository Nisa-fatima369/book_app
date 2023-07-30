import 'package:book_app/config/routes.dart';
import 'package:book_app/models/auth_data_model.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () => Navigator.pushReplacementNamed(context, Routes.pageVieew),
        ),
        title: const Text(
          'Messages',
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chatRooms')
              .where(
                'participants',
                arrayContains: FirebaseAuth.instance.currentUser!.uid,
              )
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String receiver = snapshot.data!.docs[index]['receiver'] == FirebaseAuth.instance.currentUser!.uid
                      ? snapshot.data!.docs[index]['sender']
                      : snapshot.data!.docs[index]['receiver'];
                  return FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(receiver).get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData && asyncSnapshot.connectionState == ConnectionState.done) {
                          AuthData receverData = AuthData.fromMap(asyncSnapshot.data!.data()!);
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.chat, arguments: [snapshot.data!.docs[index]['id'], receiver]);
                            },
                            leading: CircleAvatar(
                              backgroundColor: AppColors.filledColor,
                              radius: 25,
                              backgroundImage: NetworkImage(
                                receverData.profileUrl!,
                              ),
                            ),
                            title: Text(
                              receverData.fullName,
                              style: const TextStyle(
                                color: AppColors.selectedColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: FutureBuilder(
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.docs[0]['message'],
                                    style: const TextStyle(
                                      color: AppColors.selectedColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: const Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), child: Text('Loading...')),
                                );
                              },
                              future: FirebaseFirestore.instance
                                  .collection('chatRooms')
                                  .doc(snapshot.data!.docs[index]['id'])
                                  .collection('messages')
                                  .orderBy('time', descending: true)
                                  .limit(1)
                                  .get(),
                            ),
                            trailing: FutureBuilder(
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.docs[0]['time'].toDate().hour.toString() +
                                        ':' +
                                        snapshot.data!.docs[0]['time'].toDate().minute.toString(),
                                    style: const TextStyle(
                                      color: AppColors.selectedColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: const Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), child: Text('Loading...')),
                                );
                              },
                              future: FirebaseFirestore.instance
                                  .collection('chatRooms')
                                  .doc(snapshot.data!.docs[index]['id'])
                                  .collection('messages')
                                  .orderBy('time', descending: true)
                                  .limit(1)
                                  .get(),
                            ),
                          );
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 120,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });

                  // return Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //   child: Container(
                  //     height: size.height * 0.11,
                  //     decoration: BoxDecoration(
                  //       color: AppColors.filledColor,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: AppColors.filledColor,
                  //           blurRadius: 1,
                  //           spreadRadius: 2,
                  //         ),
                  //       ],
                  //     ),
                  //     child: ListTile(
                  //       onTap: () {
                  //         Navigator.pushNamed(context, Routes.chat,
                  //             arguments: [snapshot.data!.docs[index]['id'], snapshot.data!.docs[index]['receiver']]);
                  //       },
                  //       isThreeLine: true,
                  //       leading: const CircleAvatar(
                  //         radius: 25,
                  //         backgroundColor: AppColors.titleMedium,
                  //       ),
                  //       title: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Nisa Fatima',
                  //             style: Theme.of(context).textTheme.labelLarge,
                  //           ),
                  //           const Text('23:41'),
                  //         ],
                  //       ),
                  //       subtitle: Text(
                  //         'Thank You for this book. where uh are I need uh listen..How much I should have to resist.',
                  //         style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
                separatorBuilder: (context, index) => const Divider(
                  endIndent: 25,
                ),
              );
            }
            return Container();
          }),
    );
  }
}
