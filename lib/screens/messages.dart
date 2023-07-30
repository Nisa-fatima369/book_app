import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onTap: () =>
              Navigator.pushReplacementNamed(context, Routes.pageVieew),
        ),
        title: const Text(
          'Messages',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                        color: AppColors.filledColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.filledColor,
                            blurRadius: 1,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.chat);
                        },
                        isThreeLine: true,
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.titleMedium,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nisa Fatima',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const Text('23:41'),
                          ],
                        ),
                        subtitle: Text(
                          'Thank You for this book. where uh are I need uh listen..How much I should have to resist.',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

