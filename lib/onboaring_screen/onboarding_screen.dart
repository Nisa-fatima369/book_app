import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/onboaring_screen/build_page.dart';
import 'package:book_app/config/routes.dart';

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
    Size size = MediaQuery.of(context).size;
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
              
              urlImage: '',
              title: 'Exchanging \nBuying Books ',
              subtitle: 'Used and new secondhand books at great prices',
            ),
            BuildPage(
              urlImage: '',
              title: 'Not getting desired books\nin local shops?',
              subtitle: 'Find Your Desire Academic Books Here.',
            ),
            BuildPage(
              urlImage: '',
              title: 'Sell Or Donate Your Old \nBooks With Us.',
              subtitle:
                  'If You Want To Sell Or Donate Your Old Books \nWe can Help.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? GestureDetector(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.unSelectedColor,
                  backgroundColor: AppColors.selectedColor,
                  minimumSize: const Size.fromHeight(80),
                  
                ),
                onPressed: () async {
                  //navigate to choose page
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showChoose', true);
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.phoneScreen);
                },
                child: Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.titleMedium),
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
                  SizedBox(
                    width: size.width * 0.14,
                  ),

                  //dots
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 15,
                        dotColor: AppColors.selectedColor,
                        activeDotColor: AppColors.unSelectedColor,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  //next
                  InkWell(
                    onTap: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    child: Text(
                      'NEXT',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
