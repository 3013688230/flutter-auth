import 'package:flutter/material.dart';

import 'theme/style.dart';

class TextContainerWidget extends StatelessWidget {
  const TextContainerWidget({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
  });

  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color747480.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }
}
