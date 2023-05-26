import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';

final kGreyTextField = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.filledColor),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.filledColor),
      borderRadius: BorderRadius.circular(10)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.filledColor),
      borderRadius: BorderRadius.circular(10)),
  border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.filledColor),
      borderRadius: BorderRadius.circular(10)),
  fillColor: AppColors.filledColor,
  focusColor: AppColors.filledColor,
  hoverColor: AppColors.filledColor,
  filled: true,
);

final kWhiteTextField = InputDecoration(
  filled: true,
  fillColor: AppColors.secondary,
  focusColor: AppColors.secondary,
  hoverColor: AppColors.secondary,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(10)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(10)),
  border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(10)),
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
                hintText: 'Enter the value',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              );