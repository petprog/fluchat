import 'package:flutter/material.dart';

class CircularTextIcon extends StatelessWidget {
  const CircularTextIcon(
      {Key? key,
      required this.iconBackground,
      required this.iconSize,
      required this.textIconSize,
      required this.textIconColor})
      : super(key: key);

  final Color iconBackground;
  final double iconSize;
  final double textIconSize;
  final Color textIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: iconBackground,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '1',
          style: TextStyle(
            fontSize: textIconSize,
            color: textIconColor,
          ),
        ),
      ),
    );
  }
}
