import 'dart:io';
import 'package:book_app/config/routes.dart';
import 'package:book_app/models/auth_data_model.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  Future<File?> pickImage(BuildContext context, ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('users/$uid');
      UploadTask uploadTask = storageReference.putFile(image!);
      await uploadTask.whenComplete(
        () async {
          await storageReference.getDownloadURL().then(
            (value) async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({'profileUrl': value});
              auth.currentUser!.updatePhotoURL(value);
              setState(() {});
            },
          );
        },
      );
    }
    return null;
  }

  Future<void> removeProfilePicture() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference storageRef = storage.refFromURL(user.photoURL!);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileUrl': ''});
        storageRef.delete();
        Navigator.pop(context);
        setState(() {});
        print('Profile picture deleted');
      }
    } catch (e) {
      print('Error deleting profile picture: $e');
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'Profile Photo',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            GestureDetector(
              onTap: () {
                removeProfilePicture();
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        message: const Text('Select a photo for your profile picture'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              pickImage(context, ImageSource.camera);
              Navigator.pop(context);
            },
            child: const Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              pickImage(context, ImageSource.gallery);
              Navigator.pop(context);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
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
                  title: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final map = snapshot.data!.data();
                        final user = AuthData.fromMap(map);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showActionSheet(context),
                              child: user.profileUrl != null &&
                                      user.profileUrl!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.filledColor,
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        user.profileUrl!,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: AppColors.filledColor,
                                      radius: 50,
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                                    ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              user.fullName,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              user.phoneNo,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  toolbarHeight: 180,
                  collapsedHeight: 190,
                  expandedHeight: 250.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: const TabBar(
                    // isScrollable: true,
                    unselectedLabelColor: AppColors.selectedColor,
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    tabs: [
                      Tab(
                        text: 'My books',
                      ),
                      Tab(
                        text: 'Bookmarks',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('books')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Book> books = snapshot.data!.docs
                      .map((e) => Book.fromMap(e.data()))
                      .toList();
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
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
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 10),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
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
                  );
                },
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('books')
                    .where('bookMarkedUsers',
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Book> books = snapshot.data!.docs
                      .map((e) => Book.fromMap(e.data()))
                      .toList();
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
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
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 10),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              books[index].category ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: const Icon(
                                Icons.bookmark,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
