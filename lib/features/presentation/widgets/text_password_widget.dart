import 'package:flutter/material.dart';

import 'theme/style.dart';

class TextPasswordWidget extends StatefulWidget {
  const TextPasswordWidget({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
  });

  final IconData? prefixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  State<TextPasswordWidget> createState() => _TextPasswordWidgetState();
}

class _TextPasswordWidgetState extends State<TextPasswordWidget> {
  bool isObsecureText = true;

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
        obscureText: isObsecureText,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObsecureText = !isObsecureText;
              });
            },
            child: Icon(
              isObsecureText == true
                  ? Icons.panorama_fish_eye
                  : Icons.remove_red_eye,
            ),
          ),
          prefixIcon: Icon(widget.prefixIcon),
        ),
      ),
    );
  }
}
