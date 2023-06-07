import 'package:book_app/onboaring_screen/onboarding_screen.dart';
import 'package:book_app/screens/category.dart';
import 'package:book_app/screens/chat.dart';
import 'package:book_app/screens/description.dart';
import 'package:book_app/screens/home.dart';
import 'package:book_app/screens/notifications.dart';
import 'package:book_app/screens/otp.dart';
import 'package:book_app/screens/page_view.dart';
import 'package:book_app/screens/profile.dart';
import 'package:book_app/screens/recently.dart';
import 'package:book_app/screens/register.dart';
import 'package:book_app/screens/search.dart';
import 'package:book_app/screens/swap.dart';
// import 'package:book_app/test.dart';
import 'package:flutter/material.dart';
import 'package:book_app/screens/add_book.dart';
import 'package:book_app/screens/phone_screen.dart';
import 'package:book_app/screens/add_book_two.dart';
import 'package:book_app/screens/messages.dart';
import 'package:book_app/screens/settings.dart';
import 'package:book_app/screens/rate_app.dart';

class Routes {
  static const String onboardingScreen = '/onboardingScreen';
  // static const String detailScreen = 'detailScreen';
  static const String search = 'search';
  static const String description = 'description';
  static const String homeScreen = 'homeScreen';
  static const String phoneScreen = 'phoneScreen';
  static const String recently = 'recently';
  static const String register = 'register';
  static const String otp = 'otp';
  static const String add = 'add';
  static const String addBookCon = 'addBookCon';
  static const String swap = 'swap';
  static const String profile = 'profile';
  static const String chat = 'chat';
  static const String categorry = 'categorry';
  static const String pageVieew = 'pageVieew';
  static const String messages = 'messages';
  static const String notification = 'notification';
  static const String setting = 'setting';
  static const String rateApp = 'rateApp';

  MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case detailScreen:
      //   return MaterialPageRoute<DetailScreen>(
      //       builder: (context) => DetailScreen(name: 'nisa',));
      case search:
        return MaterialPageRoute<Search>(builder: (context) => const Search());
      case description:
        return MaterialPageRoute<Description>(
            builder: (context) => const Description());
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
            builder: (context) =>  Register());
      case otp:
        return MaterialPageRoute<Otp>(
          builder: (context) => Otp(
            verificationId: settings.arguments.toString(),
          ),
        );
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
      case add:
        return MaterialPageRoute<AddBook>(
            builder: (context) => const AddBook());
      case addBookCon:
        return MaterialPageRoute<AddBookContinue>(
            builder: (context) => const AddBookContinue());
      case messages:
        return MaterialPageRoute<Messages>(
            builder: (context) => const Messages());
      case notification:
        return MaterialPageRoute<Notifacation>(
            builder: (context) => const Notifacation());
      case setting:
        return MaterialPageRoute<Settings>(
            builder: (context) => const Settings());
      case rateApp:
        return MaterialPageRoute<RateApp>(
            builder: (context) => const RateApp());
      default:
        return MaterialPageRoute(
          builder: (context) => PhoneScreen(),
        );
    }
  }
}
