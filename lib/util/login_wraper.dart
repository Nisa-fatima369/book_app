import 'package:book_app/screens/page_view.dart';
import 'package:book_app/screens/phone_screen.dart';
import 'package:flutter/material.dart';

class LoginWraper extends StatelessWidget {
  const LoginWraper({super.key});

  Future<bool> getLoginData() async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getLoginData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return PageVieew();
          } else {
            return const PhoneScreen();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}
