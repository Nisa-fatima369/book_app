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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
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
        ),
      ),
    );
  }
}
