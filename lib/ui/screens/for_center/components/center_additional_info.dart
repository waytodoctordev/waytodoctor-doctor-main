import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../forms/form_components/address.dart';
import '../../../forms/form_components/profile_picture.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'doctor_center_screen.dart';

class CenterAdditionalInfoPage extends StatelessWidget {
  CenterCtrl centerCtrl = Get.put(CenterCtrl());
   final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<CenterCtrl>(
        builder: (_) => Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: Get.height * .3, child: ProfilePicture()),
                  SizedBox(
                      height: Get.height * .45,
                      child: Address(
                        formKey: centerCtrl.formKey,
                      )), //5

                  CustomElevatedButton(
                    title: 'Next'.tr,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        // print(MySharedPreferences.professionalLicense);
                        // if (MySharedPreferences.userImage.isNotEmpty ) {
                          Get.to(() => const DoctorsCenterScreen());
                        // }
                      }
                    else{
                        AppConstants().showMsgToast(context,
                            msg: 'please provide your profile image'.tr);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

