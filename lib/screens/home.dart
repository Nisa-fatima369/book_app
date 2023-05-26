import 'package:book_app/routes.dart';
import 'package:book_app/widgets/reuse_category.dart';
import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                child: Icon(Icons.search),
                onTap: () {
                  // Navigator.pushNamed(context, Routes.categorry);
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          
          child: Column(
            
            children: [
              SizedBox(height: height * 0.03),
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
                height:  height * 0.18,
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
              Container(
                height: height * 0.28,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.titleMedium,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            height: height * 0.19,
                            width: width * 0.27,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            'Book Title',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Viewed',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'see all',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: height * 0.28,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.titleMedium,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            height: height * 0.19,
                            width: width * 0.27,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            'Book Title',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.width*.14,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 6),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: AppColors.primary,
              // currentIndex: selectedIndex,
              // onTap: _animateToPage,
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: 'exchange',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'bookmark',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
