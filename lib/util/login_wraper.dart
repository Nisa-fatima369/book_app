import 'package:book_app/screens/phone_screen.dart';
import 'package:book_app/util/from_Wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWraper extends StatelessWidget {
  const LoginWraper({super.key});

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance .authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData == true) {
            return FormWrapper();
          } else {
            return PhoneScreen();
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
