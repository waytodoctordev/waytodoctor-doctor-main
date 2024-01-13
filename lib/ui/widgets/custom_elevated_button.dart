import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final double height;
  final double width;
  final double radius;
  final Color? color;
  final Color? textColor;
  final double textSize;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.onLongPressed,
    this.height = 54,
    this.width = 167,
    this.color = MyColors.primary,
    this.textColor = MyColors.white,
    this.radius = 23,
    this.textSize = 14,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        fixedSize: Size(width, height),
        elevation: 0,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: textSize, color: textColor, fontWeight: fontWeight),
      ),
    );
  }
}
