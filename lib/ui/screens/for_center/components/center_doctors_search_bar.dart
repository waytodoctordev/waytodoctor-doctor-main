import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';

import '../../../../controller/for_center/doctors_center_ctrl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/custom_text_field.dart';
class CenterDoctorsSearchBar extends StatelessWidget {
  const CenterDoctorsSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInCtrl>(
      builder: (controller) => AppBar(
       leading: const SizedBox(),
        flexibleSpace: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37),
              child: CustomTextField(
                horizontalPadding: 15,
                hintText: 'Find a Doctor, for example: Moustafa'.tr,
                onChanged: (value){
                  DoctorsCenterCtrl.find.init(
                      categoryId: MySharedPreferences.categoryId,
                      search: value,
                      centerId: MySharedPreferences.centerID);
                },
                suffixIcon: SvgPicture.asset(
                  MyIcons.search,
                  height: 24,
                  width: 24,
                  color: MyColors.blue14B,
                ),
              ),
            )
          ],
        ),
        title: SizedBox(
            height: Get.height*.05,
            child: Text( 'Doctors Center'.tr)),//centerInfo.name ??
      ),
    );
  }
}
