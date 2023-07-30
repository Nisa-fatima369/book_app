import 'package:book_app/screens/category.dart';
import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';

class ReuseCategories extends StatefulWidget {
  final IconData icon;
  final String text;
  Function? onTap;
  ReuseCategories({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  State<ReuseCategories> createState() => _ReuseCategoriesState();
}

class _ReuseCategoriesState extends State<ReuseCategories> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Categorry(categoory: widget.text),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.filledColor,
            borderRadius: BorderRadius.circular(13),
          ),
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
              ),
              Text(
                widget.text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
