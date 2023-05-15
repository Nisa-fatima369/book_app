import 'package:book_app/routes.dart';
import 'package:book_app/screens/phone_screen.dart';
import 'package:book_app/theme/theming.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboaring_screen/onboarding_screen.dart';

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
      home: OnBoarding(),
      
      // darkTheme: customDarkTheme(),
      // theme: customLightTheme(),
      // themeMode: ThemeMode.system,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes().generateRoute,
   
    );
  }
}
