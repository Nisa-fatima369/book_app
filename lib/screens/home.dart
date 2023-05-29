import 'package:book_app/config/routes.dart';
import 'package:book_app/widgets/book_title.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:book_app/widgets/reuse_category.dart';
import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.notification);
              },
              child: Icon(
                Icons.notifications_none,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.messages);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.chat,
                  color: AppColors.primary,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.selectedColor),
                  decoration: kGreyTextField.copyWith(
                    filled: true,
                    hintText: 'search',
                    prefixIcon:
                        Icon(Icons.search, color: AppColors.selectedColor),
                    suffixIcon: GestureDetector(
                      onTap: _controller.clear,
                      child: Icon(
                        Icons.cancel_rounded,
                        color: AppColors.selectedColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.categorry);
                      },
                      child: Text(
                        'see all',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.18,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
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
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently Added',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.recently);
                      },
                      child: Text(
                        'see all',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              BookWithTitle(height: height, width: width),
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Viewed',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              BookWithTitle(height: height, width: width),
            ],
          ),
        ),
           
      ),
    );
  }
}
