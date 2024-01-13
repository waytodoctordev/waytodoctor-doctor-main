import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final double diameter;
  final EdgeInsetsGeometry? padding;

  const CustomRoundedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.diameter = 50.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          fixedSize: Size(diameter, diameter),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
