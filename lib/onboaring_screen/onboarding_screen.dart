import 'package:book_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/onboaring_screen/build_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String urlImage = '';
  String title = '';
  String subtitle = '';
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: const [
            BuildPage(
              urlImage: 'assets/images/Buy.png',
              title: 'Exhanging \nBuying Books ',
              subtitle: 'Used and new secondhand books at great prices',
            ),
            BuildPage(
              urlImage: 'assets/images/Search.png',
              title: 'Not getting desired books\nin local shops?',
              subtitle: 'Find Your Desire Academic Books Here.',
            ),
            BuildPage(
              urlImage: 'assets/images/Donate.png',
              title: 'Sell Or Donate Your Old \nBooks With Us.',
              subtitle:
                  'If You Want To Sell Or Donate Your Old Books \nWe can Help.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                //navigate to choose page
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showChoose', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: const Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //skip
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )),
                  //dots
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 20,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal,
                      ),
                      //to click on dots and move
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  //next
                  TextButton(
                      onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
