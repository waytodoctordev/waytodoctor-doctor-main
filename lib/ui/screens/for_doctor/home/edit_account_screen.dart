import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/edit_accountr_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/widgets/confirm_finish_dialog.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/widgets/edit_account_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/account_component/password_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/account_component/personal_into_component.dart';
import 'package:way_to_doctor_doctor/ui/widgets/base_switch_slider.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../controller/registration/specialization_ctrl.dart';
import '../../for_center/screens/center_home_screen.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  EditAccountCtrl controller = Get.put(EditAccountCtrl());
  SpecializationCtrl specializationCtrl = Get.put(SpecializationCtrl());
  CenterCtrl centerCtrl = Get.put(CenterCtrl());
  FormCtrl formCtrl = Get.put(FormCtrl());

  bool check() {
    if (MySharedPreferences.language == 'en' ||
        MySharedPreferences.language == 'tr') {
      return controller.isPersonalInformation;
    } else {
      return !controller.isPersonalInformation;
    }
  }
  void editAddress(){
    final splitNames =  MySharedPreferences.address.split('|');
    List splitList = [];
    for (int i = 0; i < splitNames.length; i++){
      splitList.add(splitNames[i]);
    }
    formCtrl.currentCountry=  splitNames[0];
    formCtrl.currentCity=  splitNames[1];
    formCtrl.addressCtrl.text = splitList[2];
  }

  @override
  Widget build(BuildContext context) {
    !MySharedPreferences.isDoctor?
    editAddress():null;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<EditAccountCtrl>(
          init: EditAccountCtrl(),
          builder: (controller) => Column(
            children: [
              const EditAccountAppbar(),
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 20, right: 37, left: 37, bottom: 0),
                children: [
                  BaseSwitchSlider(
                    margin: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
                    textColor1: controller.isPersonalInformation
                        ? MyColors.white
                        : MyColors.blue14B,
                    textColor2: controller.isPersonalInformation
                        ? MyColors.blue14B
                        : MyColors.white,
                    color: MyColors.blue9D1,
                    title1: 'Personal information'.tr,
                    title2: 'Password'.tr,

                    isFirst: check(),
                    // MySharedPreferences.language == 'en'
                    //     ? controller.isPersonalInformation
                    //     : !controller.isPersonalInformation,
                    buttonColor: MyColors.blue14B,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: Get.height * .7,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageCtrl,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        if (index > 0) {
                          controller.setIsPersonalBool(false);
                        } else {
                          controller.setIsPersonalBool(true);
                        }
                        controller.getCurrentPage(index);
                      },
                      children: const [
                        PersonalInfoComponent(),
                        PasswordComponent(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 30),
        child: GetBuilder<EditAccountCtrl>(
          builder: (controller) => SizedBox(
            height: 125,
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const ConfirmDeleteAccountDialog();
                      },
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        side: const BorderSide(width: 10, color: MyColors.red),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    'Delete Account'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.red101,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CustomElevatedButton(
                  height: 60,
                  width: Get.width,
                  title: 'Save'.tr,
                  onPressed: () {
                    if (controller.currentPage == 0) {
                      if (controller.personalFormKey.currentState!.validate()) {
                        MySharedPreferences.isDoctor
                            ? controller
                            .updateInformation(
                            userName: controller.nameCtrl.text,
                            phone: controller.phoneNumberCtrl.text,
                            context: context)
                            .whenComplete(() {
                          Get.offAll(() => const DoctorBaseNavBar(),
                              binding: DoctorBaseNavBarBinding());
                        })
                            : specializationCtrl
                            .professionalLicenseRequest(
                            context: context,
                            name: controller.nameCtrl.text,
                            phone: controller.phoneNumberCtrl.text,
                            imageProfile: MySharedPreferences.profileImage,
                            address: '${formCtrl.currentCountry}'
                                '|${formCtrl.currentCity}'
                                '|${formCtrl.addressCtrl.text}',
                            professionalLicense:
                            specializationCtrl.professionalLicense,
                            isEditCenterInfo:true
                        );


                      } else {
                        print('in valid');
                      }
                    }
                    else if (controller.currentPage == 1) {
                      if (controller.passwordFormKey.currentState!.validate()) {
                        controller.updatePassword(
                            password: controller.newPasswordCtrl.text,
                            context: context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
