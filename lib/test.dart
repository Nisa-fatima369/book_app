import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100,
      child: Image(
        image: AssetImage('assets/images/main.png'),
      ),
    );
  }
}
