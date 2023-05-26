import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';

class Recently extends StatefulWidget {
  const Recently({super.key});

  @override
  State<Recently> createState() => _RecentlyState();
}

class _RecentlyState extends State<Recently>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      print("Selected Index: " + _controller!.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
          ],
        ),
      ),
    );
  }
}
