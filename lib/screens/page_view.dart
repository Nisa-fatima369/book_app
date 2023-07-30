import 'package:book_app/provider/bottombar_provider.dart';
import 'package:book_app/screens/add_book.dart';
import 'package:book_app/screens/home.dart';
import 'package:book_app/screens/profile.dart';
import 'package:book_app/screens/search.dart';
import 'package:book_app/screens/swap.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PageVieew extends StatefulWidget {
  const PageVieew({super.key});

  @override
  State<PageVieew> createState() => _PageVieewState();
}

class _PageVieewState extends State<PageVieew> {
  // int selectedIndex = 0;
  // PageController _pageController = PageController();
  List<Widget> screens = [
    const HomeScreen(),
    const Search(),
    const AddBook(),
    const Swap(),
    const Profile(),
  ];
//
  // _animateToPage(int pageIndex) {
  //   _pageController.animateToPage(
  //     pageIndex,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomBarProvider>(context, listen: true);
    return Scaffold(
      body: PageView(
        controller: provider.pageController,
        onPageChanged: provider.updateIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 2),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
            iconSize: 25,
            unselectedItemColor: Colors.black,
            selectedItemColor: AppColors.primary,
            currentIndex: provider.selectedIndex,
            onTap: provider.animateToPage,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.exchange),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
