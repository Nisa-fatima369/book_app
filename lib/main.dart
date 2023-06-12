import 'package:book_app/config/routes.dart';
import 'package:book_app/onboaring_screen/onboarding_screen.dart';
import 'package:book_app/theme/theming.dart';
import 'package:book_app/util/login_wraper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  firebaseAuth.setSettings(appVerificationDisabledForTesting: false);
  final prefs = await SharedPreferences.getInstance();
  final showChoose = prefs.getBool('showChoose') ?? false;

  return runApp(
    BookApp(
      showChoose: showChoose,
    ),
  );
}

class BookApp extends StatelessWidget {
  final bool showChoose;
  const BookApp({super.key, required this.showChoose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Book App',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes().generateRoute,
        initialRoute: showChoose ? "loginWrapper" : "/onboardingScreen",
        routes: {
          'loginWrapper': (context) => const LoginWraper(),
          "/onboardingScreen": (context) => const OnBoarding(),
        },
      ),
    );
  }
}
