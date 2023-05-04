import 'package:flutter/material.dart';

import 'theme/style.dart';

class ContainerButtonWidget extends StatelessWidget {
  const ContainerButtonWidget({
    super.key,
    this.tap,
    required this.title,
  });

  final String title;
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 44.0,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
