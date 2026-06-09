import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class FormCongratulations extends StatelessWidget {
  const FormCongratulations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        FadeInDown(
          from: 6,
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 150),
          child: Text(
            'Congratulations'.tr,
            style: const TextStyle(
              fontSize: 26,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        //
        FadeInDown(
          from: 6,
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 300),
          child: Text(
            MySharedPreferences.fName,
            style: const TextStyle(
              fontSize: 26,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        MySharedPreferences.lastScreen == 'BaseNavBar'
            ? FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: Text(
                  'Updated Successfully'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
