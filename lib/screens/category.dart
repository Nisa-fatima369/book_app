import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/reuse_category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categorry extends StatelessWidget {
  const Categorry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Categories',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: GridView.count(
          crossAxisSpacing: 15,
          mainAxisSpacing: 9,
          crossAxisCount: 3,
          children: <Widget>[
            ReuseCategories(
              text: 'Business',
              icon: Icons.business_center,
            ),
            ReuseCategories(
              text: 'Education',
              icon: FontAwesomeIcons.bookOpen,
            ),
            ReuseCategories(
              text: 'Romance',
              icon: FontAwesomeIcons.heart,
            ),
            ReuseCategories(
              text: 'Children',
              icon: FontAwesomeIcons.child,
            ),
            ReuseCategories(
              text: 'Self learn',
              icon: FontAwesomeIcons.graduationCap,
            ),
            ReuseCategories(
              text: 'Economy',
              icon: FontAwesomeIcons.moneyBill,
            ),
          ],
        ),
      ),
    );
  }
}
