import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateApp extends StatelessWidget {
  const RateApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.30,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Enjoying the app? Take a moment to rate us',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: size.height * 0.04),
            _ratingBar(),
            SizedBox(height: size.height * 0.009),
            Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.filledColor,
            ),
            SizedBox(height: size.height * 0.009),
            GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'SUBMIT FEEDBACK',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _ratingBar() {
  return RatingBar.builder(
    initialRating: 3,
    itemCount: 5,
    itemBuilder: (context, index) {
      switch (index) {
        case 0:
          return Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          );
        case 1:
          return Icon(
            Icons.sentiment_dissatisfied,
            color: Colors.redAccent,
          );
        case 2:
          return Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          );
        case 3:
          return Icon(
            Icons.sentiment_satisfied,
            color: Colors.lightGreen,
          );
        case 4:
          return Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
          );
        default:
          return Container();
      }
    },
    onRatingUpdate: (rating) {
      // print(rating);
    },
  );
}


// Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(
//                   FontAwesomeIcons.faceFrown,
//                   color: AppColors.titleMedium,
//                 ),
//                 Icon(
//                   FontAwesomeIcons.faceMehBlank,
//                   color: AppColors.titleMedium,
//                 ),
//                 Icon(
//                   FontAwesomeIcons.faceMeh,
//                   color: AppColors.titleMedium,
//                 ),
//                 Icon(
//                   FontAwesomeIcons.faceSmile,
//                   color: AppColors.titleMedium,
//                 ),
//                 Icon(
//                   FontAwesomeIcons.faceGrinHearts,
//                   color: AppColors.titleMedium,
//                 ),
//               ],
//             ),