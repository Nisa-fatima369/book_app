import 'package:book_app/config/routes.dart';
import 'package:book_app/screens/rate_app.dart';
import 'package:book_app/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
        ),
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.04),
          Listtiles(
            title: 'Notifications',
            onPressed: () {
              // showModalBottomSheet(
              //   backgroundColor: Colors.white,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(10),
              //       topRight: Radius.circular(10),
              //     ),
              //   ),
              //   context: context,
              //   builder: (BuildContext context) {
              //     return const Bookings();
              //   },
              // );
            },
            icon: Icons.toggle_off,
          ),
          Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          Listtiles(
            title: 'Light/Dark theme',
            onPressed: () {},
            icon: Icons.toggle_off,
          ),
          Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          Listtiles(
              title: 'Rate the App',
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return const RateApp();
                  },
                );
              },
              icon: Icons.arrow_forward_ios),
          Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          Listtiles(
            title: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: Icons.logout,
          ),
          // Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          // Listtiles(title: 'Account Details', onPressed: () {}),
          // Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          // Listtiles(title: 'Marketings', onPressed: () {}),
          // Divider(color: Colors.grey.shade400, indent: 40, endIndent: 40),
          // Listtiles(title: 'Notification Settings', onPressed: () {}),
        ],
      ),
    );
  }
}

class Listtiles extends StatelessWidget {
  const Listtiles({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 8),
      child: ListTile(
        title: Text(
          title,
        ),
        trailing: InkWell(
          child: Icon(
            icon,
            size: 26,
            color: AppColors.selectedColor,
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}

// showModalBottomSheet(
                //   backgroundColor: Colors.white,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(10),
                //       topRight: Radius.circular(10),
                //     ),
                //   ),
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const Bookings();
                //   },
                // );