import 'package:flutter/material.dart';

import 'theme/style.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 35.0,
              color: greenColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(
          thickness: 1.0,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
