import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';

class BookWithTitle extends StatelessWidget {
  BookWithTitle({
    super.key,
    required this.height,
    required this.width,
    this.onTap,
  });

  final double height;
  final double width;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.28,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.description);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.filledColor,
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
            ),
          );
        },
      ),
    );
  }
}
