import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

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
  final TextEditingController controller2 = TextEditingController();
  bool isObsecureText = true;
  bool success = false;
  late bool _isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color747480.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          TextField(
            obscureText: isObsecureText,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isShowPassword = _isShowPassword == false ? true : false;
                  });
                },
                child: Icon(_isShowPassword == false
                    ? Icons.remove_red_eye
                    : Icons.panorama_fish_eye),
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 207, 207, 207), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: success ? Colors.green : Colors.red, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
