import 'package:flutter/material.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
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
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.white,
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
        suffixIcon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
