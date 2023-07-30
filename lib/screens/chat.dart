import 'package:book_app/config/routes.dart';
import 'package:book_app/models/auth_data_model.dart';
import 'package:book_app/theme/color.dart';
import 'package:book_app/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final List chatRoom;
  const Chat({super.key, required this.chatRoom});

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
        title: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(widget.chatRoom[1]).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final map = snapshot.data!.data();
              final user = AuthData.fromMap(map);
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: user.profileUrl != null && user.profileUrl!.isNotEmpty
                        ? CircleAvatar(
                            backgroundColor: AppColors.filledColor,
                            radius: 18,
                            backgroundImage: NetworkImage(
                              user.profileUrl!,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundColor: AppColors.filledColor,
                            radius: 18,
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatRooms')
                    .doc(widget.chatRoom[0])
                    .collection('messages')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final map = snapshot.data!.docs[index].data();
                        final message = Message.fromMap(map);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment:
                                message.sender == FirebaseAuth.instance.currentUser!.uid ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: message.sender == FirebaseAuth.instance.currentUser!.uid ? AppColors.primary : AppColors.filledColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message.message,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: message.sender == FirebaseAuth.instance.currentUser!.uid ? Colors.white : Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SizedBox(
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
                    onTap: () async {
                      if (messageTextController.text.isNotEmpty) {
                        await FirebaseFirestore.instance.collection('chatRooms').doc(widget.chatRoom[0]).collection('messages').add({
                          'message': messageTextController.text,
                          'sender': FirebaseAuth.instance.currentUser!.uid,
                          'receiver': widget.chatRoom[1],
                          'time': DateTime.now(),
                        });
                        messageTextController.clear();
                      }
                    },
                    child: const Icon(
                      Icons.send_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String message;
  final String sender;
  final String receiver;
  final DateTime time;

  Message({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.time,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      sender: map['sender'],
      receiver: map['receiver'],
      time: map['time'].toDate(),
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