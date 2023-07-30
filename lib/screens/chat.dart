import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.messages);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.selectedColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.titleMedium,
            ),
            Text(
              'Nisa Fatima',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: size.height * 0.06,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageTextController,
                      style: Theme.of(context).textTheme.labelLarge,
                      decoration: kGreyTextField.copyWith(
                        hintText: 'Message',
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.send_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 bottomLeft: Radius.circular(30.0),
//                 bottomRight: Radius.circular(30.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 20.0,
//                 ),
//                 child: Text(
//                   'hello how are uh',
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: AppColors.titleMedium,
//                   ),
//                 ),
//               ),
//             ),