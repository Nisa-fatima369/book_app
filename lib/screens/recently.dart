import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';

class Recently extends StatefulWidget {
  const Recently({super.key});

  @override
  State<Recently> createState() => _RecentlyState();
}

class _RecentlyState extends State<Recently> {
  // generate dummy data to feed the second SliverGrid
  final List _gridItems = List.generate(90, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Recently Added'),
      ),
      body: CustomScrollView(
        slivers: [
          // // SliverAppBar #1
        
          const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0)),

          // SliverGrid #2 (with dynamic content)
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RecentlyAdded(size: size);
              },
              childCount: _gridItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentlyAdded extends StatelessWidget {
  RecentlyAdded({
    this.onTap,
    super.key,
    required this.size,
  });

  final Size size;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.25,
            width: double.infinity,
            color: AppColors.filledColor,
          ),
          Text(
            'Book Name',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: size.height * 0.009),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.description);
            },
            child: Text(
              'category',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: AppColors.selectedColor,
//           ),
//         ),
//         title: Text('Recently Added'),
//       ),
//       body: 
//     );


// class ItemTile extends StatelessWidget {
//   final int itemNo;

//   const ItemTile(
//     this.itemNo,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final Color color = Colors.primaries[itemNo % Colors.primaries.length];
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         tileColor: color.withOpacity(0.3),
//         onTap: () {},
//         leading: Container(
//           width: 50,
//           height: 30,
//           color: color.withOpacity(0.5),
//           child: Placeholder(
//             color: color,
//           ),
//         ),
//         title: Text(
//           'Product $itemNo',
//           key: Key('text_$itemNo'),
//         ),
//       ),
//     );
//   }
// }


// DefaultTabController(
//       length: 6,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.homeScreen);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: AppColors.selectedColor,
//             ),
//           ),
//           title: Text(
//             'SuggestName',
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: GestureDetector(
//                 onTap: () => Navigator.pushNamed(context, Routes.search),
//                 child: Icon(
//                   Icons.search,
//                   color: AppColors.selectedColor,
//                 ),
//               ),
//             ),
//           ],
//           bottom: PreferredSize(
//               child: TabBar(
//                   overlayColor: MaterialStateProperty.all(Colors.transparent),
//                   // indicator: BoxDecoration(
//                   //   borderRadius: BorderRadius.circular(20),
//                   //   color: AppColors.primary,
//                   // ),
//                   indicatorColor: AppColors.primary,
//                   isScrollable: true,
//                   unselectedLabelColor: AppColors.selectedColor,
//                   // indicatorColor: AppColors.secondary,
//                   labelColor: AppColors.selectedColor,
//                   tabs: [
//                     Tab(
//                       child: Text('All'),
//                     ),
//                     Tab(
//                       child: Text('Business'),
//                     ),
//                     Tab(
//                       child: Text('Education'),
//                     ),
//                     Tab(
//                       child: Text('Romance'),
//                     ),
//                     Tab(
//                       child: Text('Children'),
//                     ),
//                     Tab(
//                       child: Text('Economy'),
//                     )
//                   ]),
//               preferredSize: Size.fromHeight(50.0)),
//         ),
//         body: Container(
//           height: double.maxFinite,
//           child: TabBarView(
//             children: <Widget>[
//               SingleChildScrollView(
//                 child: ListView.builder(
//                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //   crossAxisCount: 3,
//                   //   mainAxisSpacing: 10,
//                   //   crossAxisSpacing: 10,
//                   // ),
//                   itemCount: 50,
//                   itemBuilder: ((context, index) {
//                     return ItemTile(index);
//                   }),
//                   padding: EdgeInsets.all(10),
//                   shrinkWrap: true,
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 2'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 3'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 4'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 5'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 6'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );