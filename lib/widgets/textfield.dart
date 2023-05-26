import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.hint,
    this.obscureText,
    this.enable,
    required this.controler,
    this.validattor,
    this.keyboardType,
    this.inputFormatter,
    this.suffixicon,
    this.maxline,
  });

  final String hint;
  final bool? obscureText;
  final bool? enable;
  final TextEditingController controler;
  final String? Function(String?)? validattor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixicon;
  int? maxline;
  Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      obscureText: obscureText == false,
      onChanged: onchange,
      inputFormatters: inputFormatter,
      keyboardType: keyboardType,
      controller: controler,
      validator: validattor,
      textAlign: TextAlign.left,
      // cursorColor: Theme.of(context).primaryColor,
      textDirection: TextDirection.ltr,
      maxLines: maxline,

      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        hintText: hint,
        prefixIcon: suffixicon,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.filledColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.filledColor),
        ),
        fillColor: AppColors.filledColor,
        focusColor: AppColors.filledColor,
        filled: true,
      ),
    );
  }
}
