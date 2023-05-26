import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notifacation extends StatefulWidget {
  const Notifacation({super.key});

  @override
  State<Notifacation> createState() => NotifacationState();
}

class NotifacationState extends State<Notifacation> {
  // String? title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child:
                        //  Container(
                        //   height: size.height * 0.1,
                        //   decoration: BoxDecoration(
                        //     color: AppColors.filledColor,
                        //     borderRadius: BorderRadius.circular(10),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: AppColors.filledColor,
                        //         blurRadius: 1,
                        //         spreadRadius: 2,
                        //       ),
                        //     ],
                        //   ),
                        // child:
                        ListTile(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      isThreeLine: true,
                      leading: CircleAvatar(
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
                          Text(formattedDate),
                        ],
                      ),
                      subtitle: Text(
                        'Thank You for this book. where uh are I need uh listen..How much I should have to resist.',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // ),
                  );
                },
                itemCount: 7,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
