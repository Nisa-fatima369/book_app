import 'package:book_app/routes.dart';
import 'package:flutter/material.dart';

class Categorry extends StatelessWidget {
  const Categorry({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.homeScreen),
                  ),
                  SizedBox(width: size.width * 0.28),
                  Text('Category',
                      style: Theme.of(context).textTheme.headlineSmall),
                  // SizedBox(width: size.width * 0.03),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
