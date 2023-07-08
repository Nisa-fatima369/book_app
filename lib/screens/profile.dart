import 'dart:io';
import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
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
          FirebaseStorage.instance.ref().child('profile/$uid');
      UploadTask uploadTask = storageReference.putFile(image!);
      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((value) async {
          await auth.currentUser!.updatePhotoURL(value);
        });
      });
    }
    return null;
  }

  Future<void> removeProfilePicture() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference storageRef = storage.ref().child('profile/${user.uid}');
        await storageRef.delete();
        Navigator.pop(context);
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
                  title: StreamBuilder(
                    stream: FirebaseAuth.instance.userChanges(),
                    initialData: FirebaseAuth.instance.currentUser,
                    builder: (context, snapshot) {
                      User? user = snapshot.data;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => _showActionSheet(context),
                            child: user?.photoURL != null
                                ? CircleAvatar(
                                    backgroundColor: AppColors.filledColor,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      user!.photoURL.toString(),
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
                            user?.displayName.toString() ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            user?.email.toString() ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      );
                    },
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
