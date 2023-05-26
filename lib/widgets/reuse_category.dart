import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';

class ReuseCategories extends StatelessWidget {
  final IconData icon;
  final String text;
  const ReuseCategories({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.titleMedium,
            borderRadius: BorderRadius.circular(13),
          ),
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
              ),
              Text(
                text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
