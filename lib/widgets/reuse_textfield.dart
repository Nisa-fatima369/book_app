import 'package:flutter/material.dart';

class ReuseTextFields extends StatefulWidget {
  const ReuseTextFields({
    Key? key,
    required this.hintText,
    required this.onTap,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final VoidCallback onTap;
  final TextEditingController? controller;

  @override
  State<ReuseTextFields> createState() => _ReuseTextFieldsState();
}

class _ReuseTextFieldsState extends State<ReuseTextFields> {
  final TextEditingController _optioncontroller = TextEditingController();
  bool selectedOption = false;

  List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
    'Option 6',
    'Option 7',
    'Option 8',
    'Option 9',
    'Option 10',
    'Option 11',
    'Option 12',
    'Option 13',
    'Option 14',
  ];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
        hintText: widget.hintText,
        suffixIcon: InkWell(
          onTap: () {
            _optionsDialog(context, _optioncontroller, options);
          },
          child: Icon(
            Icons.arrow_drop_down,
            color: Colors.teal,
            size: 24,
          ),
        ),
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

_optionsDialog(
  BuildContext context,
  TextEditingController controller,
  List<String> options,
) {
  showDialog(
    context: context,
    builder: (context) {
      bool selectedOption = true;
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height * 1.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ListView.separated(
            itemCount: 14,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  selectedOption = !selectedOption;
                  controller.text = options[index];
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    options[index],
                  ),
                  trailing: InkWell(
                    child: selectedOption == index
                        ? Icon(
                            Icons.circle_outlined,
                            color: Colors.grey.shade600,
                          )
                        : Icon(
                            Icons.circle_rounded,
                            color: Colors.teal,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
