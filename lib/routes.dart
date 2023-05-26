import 'package:book_app/onboaring_screen/onboarding_screen.dart';
import 'package:book_app/screens/category.dart';
import 'package:book_app/screens/chat.dart';
import 'package:book_app/screens/home.dart';
import 'package:book_app/screens/otp.dart';
import 'package:book_app/screens/page_view.dart';
import 'package:book_app/screens/profile.dart';
import 'package:book_app/screens/recently.dart';
import 'package:book_app/screens/register.dart';
import 'package:book_app/screens/swap.dart';
import 'package:flutter/material.dart';
import 'package:book_app/screens/phone_screen.dart';

class Routes {
  static const String onboardingScreen = '/onboardingScreen';
  // static const String mainScreen = '/mainScreen';
  // static const String signInScreen = '/signInScreen';
  // static const String signUpScreen = '/signUpScreen';
  static const String homeScreen = 'homeScreen';
  static const String phoneScreen = 'phoneScreen';
  static const String recently = 'recently';
  static const String register = 'register';
  static const String otp = 'otp';
  static const String swap = 'swap';
  static const String profile = 'profile';
  static const String chat = 'chat';
  static const String categorry = 'categorry';
  static const String pageVieew = 'pageVieew';

  MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case mainScreen:
      //   return MaterialPageRoute<MainScreen>(
      //       builder: (context) => const MainScreen());
      // case signInScreen:
      //   return MaterialPageRoute<SignIn>(builder: (context) => const SignIn());
      // case signUpScreen:
      //   return MaterialPageRoute<SignUp>(builder: (context) => const SignUp());
      case homeScreen:
        return MaterialPageRoute<HomeScreen>(
            builder: (context) => const HomeScreen());
      case onboardingScreen:
        return MaterialPageRoute<OnBoarding>(
            builder: (context) => const OnBoarding());
      case phoneScreen:
        return MaterialPageRoute<PhoneScreen>(
            builder: (context) => PhoneScreen());
      case recently:
        return MaterialPageRoute<Recently>(
            builder: (context) => const Recently());
      case register:
        return MaterialPageRoute<Register>(
            builder: (context) => const Register());
      case otp:
        return MaterialPageRoute<Otp>(builder: (context) => const Otp());
      case chat:
        return MaterialPageRoute<Chat>(builder: (context) => const Chat());
      case profile:
        return MaterialPageRoute<Profile>(
            builder: (context) => const Profile());
      case swap:
        return MaterialPageRoute<Swap>(builder: (context) => const Swap());
      case categorry:
        return MaterialPageRoute<Categorry>(
            builder: (context) => const Categorry());
      case pageVieew:
        return MaterialPageRoute<PageVieew>(
            builder: (context) => const PageVieew());
      default:
        return MaterialPageRoute(builder: (context) => const Recently());
    }
  }
}
