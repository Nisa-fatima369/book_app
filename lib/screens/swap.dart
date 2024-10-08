import 'package:book_app/config/routes.dart';
import 'package:book_app/models/book_models.dart';
import 'package:book_app/provider/bottombar_provider.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/buy_exchange_donate_helper.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Swap extends StatefulWidget {
  const Swap({super.key});

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final provider = Provider.of<BottomBarProvider>(context);

    final List<String> tabs = <String>[
      'Sale',
      'Exchange',
      'Donate',
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: AppColors.selectedColor,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        provider.updateIndex(1);
                        provider.animateToPage(1);
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _controller,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.selectedColor),
                        decoration: kGreyTextField.copyWith(
                          filled: true,
                          hintText: 'search',
                          prefixIcon: const Icon(Icons.search,
                              color: AppColors.selectedColor),
                          suffixIcon: GestureDetector(
                            onTap: _controller.clear,
                            child: const Icon(
                              Icons.cancel_rounded,
                              color: AppColors.selectedColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  toolbarHeight: 90,
                  collapsedHeight: 100,
                  pinned: true,
                  expandedHeight: 170.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    unselectedLabelColor: AppColors.secondary,
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              buy_method(),
              exchange_method(),
              donate_method(),
            ],
          ),
        ),
      ),
    );
  }
}
