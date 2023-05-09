import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'theme/style.dart';

class TextContainerWidget extends StatefulWidget {
  const TextContainerWidget({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.onChange,
    this.prefixIcon,
  });

  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function? onChange;

  @override
  State<TextContainerWidget> createState() => _TextContainerWidgetState();
}

class _TextContainerWidgetState extends State<TextContainerWidget> {
  late bool isEmailCorrect = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.white,
      onChanged: (val) {
        setState(() {
          isEmailCorrect = isEmail(val);
        });
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.white,
        ),
        suffixIcon: isEmailCorrect == false
            ? const Icon(
                Icons.close_sharp,
                color: Colors.red,
              )
            : const Icon(
                Icons.done,
                color: Colors.green,
              ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            borderRadius: BorderRadius.circular(10)),
        floatingLabelStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isEmailCorrect == false ? Colors.red : Colors.green,
              width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
