import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final Color color;

  const CustomMarker({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Icon(
        Icons.location_on,
        size: 40,
        color: color,
      ),
    );
  }
}
