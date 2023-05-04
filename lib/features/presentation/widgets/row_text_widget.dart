import 'package:flutter/material.dart';

import 'theme/style.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget({
    super.key,
    this.mainAxisAlignment,
    this.onTap,
    this.title1,
    this.title2,
  });

  final MainAxisAlignment? mainAxisAlignment;
  final String? title1, title2;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _rowTextWidget();
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: mainAxisAlignment == null
          ? MainAxisAlignment.start
          : mainAxisAlignment!,
      children: [
        Text(title1!),
        InkWell(
          onTap: onTap,
          child: Text(
            title2!,
            style: TextStyle(
              color: greenColor,
            ),
          ),
        ),
      ],
    );
  }
}
