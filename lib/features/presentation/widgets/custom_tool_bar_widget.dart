import 'package:flutter/material.dart';
import 'package:flutter_auth/features/presentation/widgets/theme/style.dart';

typedef ToolBarIndexController = Function(int index);

class CustomToolBarWidget extends StatelessWidget {
  const CustomToolBarWidget({
    super.key,
    this.pageIndex,
    required this.toolBarIndexController,
  });

  final int? pageIndex;
  final ToolBarIndexController toolBarIndexController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: ToolBarItem(
              onTap: () {
                toolBarIndexController(0);
              },
              title: 'Users',
              borderColor: pageIndex == 0 ? Colors.white : Colors.transparent,
              textColor: pageIndex == 0 ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: ToolBarItem(
              onTap: () {
                toolBarIndexController(1);
              },
              title: 'Profile',
              borderColor: pageIndex == 1 ? Colors.white : Colors.transparent,
              textColor: pageIndex == 1 ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ToolBarItem extends StatelessWidget {
  const ToolBarItem({
    super.key,
    this.borderColor,
    this.borderWidth = 3.0,
    this.onTap,
    this.textColor,
    this.title,
  });

  final Color? borderColor, textColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: borderColor!, width: borderWidth!),
          ),
        ),
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
