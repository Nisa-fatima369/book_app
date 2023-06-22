import 'dart:io';

import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  // File? imagecam;

  // Future<File?> pickImageCam(BuildContext context) async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     setState(() {
  //       imagecam = File(pickedImage.path);
  //     });
  //   }
  //   return null;
  // }

  Future<File?> pickImageGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
    return null;
  }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //                 leading: const Icon(Icons.photo_library),
  //                 title: const Text('Gallery'),
  //                 onTap: () {
  //                   pickImageGallery;
  //                   // Navigator.of(context).pop();
  //                 }),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 pickImageCam;
  //                 // Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    final List<String> tabs = <String>[
      'Your Book',
      'Bookmarks',
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.setting);
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.settings,
                  color: AppColors.selectedColor,
                ),
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: AppColors.secondary,
                  title: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // FirebaseFirestore firebaseFirestore =
                          //     FirebaseFirestore.instance;
                          // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                          // await firebaseFirestore
                          //     .collection('users')
                          //     .doc(firebaseAuth.currentUser!.uid)
                          //     .set({}).then(
                          //   (value) {
                          //     print('success');
                          //   },
                          // ).onError(
                          //   (error, stackTrace) {
                          //     print(error.toString());
                          //   },
                          // );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.filledColor,
                          radius: 50,
                          child: image != null
                              ? ClipOval(
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                )
                              : InkWell(
                                  onTap: () => pickImageGallery(context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Nisa Fatima',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        'Faisalabad, Pakistan',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  toolbarHeight: 180,
                  collapsedHeight: 190,
                  pinned: true,
                  expandedHeight: 250.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    // isScrollable: true,
                    unselectedLabelColor: AppColors.selectedColor,
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
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
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.description);
                                      },
                                      leading: Container(
                                        height: 130,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: AppColors.selectedColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      title: Text(
                                        'Book Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text(
                                        'Author Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                              childCount: 50,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
