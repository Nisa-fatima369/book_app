import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';



// Future<File?> pickImageGallery(BuildContext context) async {
//   File? image;
//   try {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       image = File(pickedImage.path);
      
//     }
//   } catch (e) {
//    print(e);
//   }
// }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: const Icon(Icons.photo_library),
//                     title: const Text('Gallery'),
//                     onTap: () {
//                       pickImageGallery;
//                       Navigator.of(context).pop();
//                     }),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     pickImageCam;
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
