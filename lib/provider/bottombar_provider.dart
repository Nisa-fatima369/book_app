import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarProvider extends ChangeNotifier{
   int selectedIndex = 0;
  PageController pageController = PageController();

  animateToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ); 
  }

  updateIndex(int value){
    selectedIndex = value;
    notifyListeners();
  }
}