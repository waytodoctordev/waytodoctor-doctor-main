import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class Gender extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const Gender({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Gender:'.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Select your gender from the list'.tr,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            from: 6,
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 150),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: MyColors.fillColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: GetBuilder<FormCtrl>(
                builder: (controller) => DropdownButton(
                  borderRadius: BorderRadius.circular(26),
                  underline: const SizedBox(),
                  value: controller.genderDropdownvalue,
                  style: const TextStyle(
                    fontSize: 18,
                    color: MyColors.blue14B,
                  ),
                  itemHeight: 60,
                  alignment: Alignment.center,
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      height: 7,
                      width: 14,
                      color: MyColors.blue14B,
                    ),
                  ),
                  elevation: 1,
                  items: controller.genders.map(
                    (String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            items,
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: MyColors.blue14B,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    controller.setGender(newValue.toString());
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
