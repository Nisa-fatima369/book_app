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
      cursorColor: Theme.of(context).primaryColor,
      textDirection: TextDirection.ltr,
      maxLines: maxline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
        hintText: hint,
        prefixIcon: suffixicon,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        fillColor: Colors.grey.shade200,
        focusColor: Colors.grey.shade100,
        filled: true,
      ),
    );
  }
}
