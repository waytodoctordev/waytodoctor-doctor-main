import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Image.asset(
        MyImages.wayToDoctorLogo,
        height: size.height * .18,
        width: 269,
      ),
    );
  }
}
