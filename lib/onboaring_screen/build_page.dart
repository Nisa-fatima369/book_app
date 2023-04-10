import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  final String urlImage;
  final String title;
  final String subtitle;

  const BuildPage({
    super.key,
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.teal.shade700,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset(
          urlImage,
          width: 275,
          height: 275,
        ),
      ],
    );
  }
}