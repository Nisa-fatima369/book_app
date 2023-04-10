import 'package:book_app/main_screen.dart';
import 'package:book_app/onboaring_screen/onboarding_screen.dart';
import 'package:book_app/sign_in.dart';
import 'package:book_app/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnBoarding(),
    );
  }
}
