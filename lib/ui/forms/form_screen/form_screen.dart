import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/address.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/date_of_birth.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/full_name.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/gender.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/marital_status.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/national_id.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/form_congratulations.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_components/profile_picture.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_screen/widgets/custom_form_indicator.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_screen/widgets/form_appbar.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormStateScreen();
}

GlobalKey<FormState> _formKeyFullName = GlobalKey<FormState>();
GlobalKey<FormState> _formKeyNationalId = GlobalKey<FormState>();
GlobalKey<FormState> _formKeyDateOfBirth = GlobalKey<FormState>();
GlobalKey<FormState> _formKeyGender = GlobalKey<FormState>();
GlobalKey<FormState> _formKeyMaritalStatus = GlobalKey<FormState>();
GlobalKey<FormState> _formKeyAddress = GlobalKey<FormState>();

class _FormStateScreen extends State<FormScreen> {
  List<Widget> forms = [
    FullName(formKey: _formKeyFullName), //0
    NationalId(formKey: _formKeyNationalId), //1
    DateOfBirth(formKey: _formKeyDateOfBirth), //2
    Gender(formKey: _formKeyGender), //3
    MaritalStatus(formKey: _formKeyMaritalStatus), //4
    Address(formKey: _formKeyAddress), //5
     ProfilePicture(), //6
    const FormCongratulations(), //7
  ];
  @override
  void initState() {
    Get.put(UserLocationCtrl(), permanent: true);
    Get.put(MapController(), permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
          child: GetBuilder<FormCtrl>(
            builder: (controller) => Column(
              children: [
                FormAppbar(
                  sectionName: 'Personal information'.tr,
                  sectionDescription:
                      'The user bears all responsibility for the validity of the data entered in our system'
                          .tr,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return forms[MySharedPreferences.formCurrentIndex];
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: controller.formPageCtrl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<FormCtrl>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 0),
          height: MySharedPreferences.formCurrentIndex != forms.length - 1
              ? 180
              : 130,
          child: Column(
            children: [
              const SizedBox(height: 5),
              MySharedPreferences.formCurrentIndex != forms.length - 1
                  ? CustomFormIndicator(
                      count: forms.length,
                      currentIndex:
                          MySharedPreferences.formIndicatorCurrentIndex,
                      carouselController: controller.formPageIndicatorCtrl,
                    )
                  : const SizedBox(height: 10),
              const SizedBox(height: 10),
              MySharedPreferences.formCurrentIndex != forms.length - 1
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'remaining '.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${forms.length - 1 - MySharedPreferences.formIndicatorCurrentIndex}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' questions'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(height: 10),
              const SizedBox(height: 5),
              MySharedPreferences.formCurrentIndex != forms.length - 1
                  ? Center(
                      child: Text(
                        'All questions must be answered carefully.'.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: MyColors.blue14B,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox(height: 10),
              const SizedBox(height: 10),
              CustomElevatedButton(
                title: _getButtonTitle(),
                color: MyColors.blue14B,
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  if (MySharedPreferences.formCurrentIndex == 0) {
                    if (_formKeyFullName.currentState!.validate()) {
                      MySharedPreferences.fName = controller.firstNameCtrl.text;
                      MySharedPreferences.sName =
                          controller.secondNameCtrl.text;
                      MySharedPreferences.tName = controller.thirdNameCtrl.text;
                      MySharedPreferences.lName =
                          controller.familyNameCtrl.text;
                      FocusManager.instance.primaryFocus?.unfocus();
                      Map<String, dynamic> fullNameData = {
                        "step": '3',
                        'active': '2',
                        "question_number": "1",
                        'name': MySharedPreferences.fName,
                        'second_name': MySharedPreferences.sName,
                        'third_name': MySharedPreferences.tName,
                        'last_name': MySharedPreferences.lName,
                      };
                      controller.updateUserData(
                        dataBody: fullNameData,
                        context: context,
                      );
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 1) {
                    if (_formKeyNationalId.currentState!.validate()) {
                      MySharedPreferences.nationalId =
                          controller.nationalIdCtrl.text;
                      FocusManager.instance.primaryFocus?.unfocus();

                      Map<String, dynamic> nationalIdData = {
                        "step": '3',
                        "question_number": "2",
                        'national_id': MySharedPreferences.nationalId,
                      };
                      controller.updateUserData(
                        dataBody: nationalIdData,
                        context: context,
                      );
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 2) {
                    if (_formKeyDateOfBirth.currentState!.validate()) {
                      MySharedPreferences.dateOfBirth =
                          "${controller.dayCtrl.text}-${controller.monthCtrl.text}-${controller.yearCtrl.text}";
                      FocusManager.instance.primaryFocus?.unfocus();
                      Map<String, dynamic> dateOfBirthData = {
                        "step": '3',
                        "question_number": "3",
                        'date_of_birth': MySharedPreferences.dateOfBirth
                            .split('-')
                            .reversed
                            .join('-')
                            .toString()
                            .replaceAll(',', '-'),
                      };
                      controller.updateUserData(
                        dataBody: dateOfBirthData,
                        context: context,
                      );
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 3) {
                    if (_formKeyGender.currentState!.validate()) {
                      MySharedPreferences.gender =
                          controller.genderDropdownvalueEnglish;
                      FocusManager.instance.primaryFocus?.unfocus();
                      Map<String, dynamic> genderData = {
                        "step": '3',
                        "question_number": "4",
                        'gender': MySharedPreferences.gender,
                      };
                      controller.updateUserData(
                        dataBody: genderData,
                        context: context,
                      );
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 4) {
                    if (_formKeyMaritalStatus.currentState!.validate()) {
                      MySharedPreferences.status =
                          controller.maritalStatusValue;
                      FocusManager.instance.primaryFocus?.unfocus();
                      Map<String, dynamic> statusData = {
                        "step": '3',
                        "question_number": "5",
                        'status': controller.maritalStatusValueEngish,
                      };
                      controller.updateUserData(
                        dataBody: statusData,
                        context: context,
                      );
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 5) {
                    if (_formKeyAddress.currentState!.validate()) {
                      MySharedPreferences.address = controller.addressCtrl.text;
                      MySharedPreferences.country = controller.currentCountry;
                      MySharedPreferences.city = controller.currentCity;
                      FocusManager.instance.primaryFocus?.unfocus();
                      // هنا هعمل ابديت للعنوان في اليوزر والعنوان في الدكتور
                      Map<String, dynamic> addressData = {
                        "step": '3',
                        "question_number": '6',
                        'nationality': MySharedPreferences.country,
                        'country': MySharedPreferences.city,
                        'city': MySharedPreferences.address,
                      };
                      if (MySharedPreferences.isDoctor) {
                        controller
                            .updateDoctorAddress(
                          lat: MySharedPreferences.lat,
                          long: MySharedPreferences.long,
                          address: MySharedPreferences.address,
                          context: context,
                        )
                            .whenComplete(
                          () {
                            controller.updateUserData(
                              dataBody: addressData,
                              context: context,
                            );
                          },
                        );
                      } else {
                        controller
                            .updateClinicAddress(
                          lat: MySharedPreferences.lat,
                          long: MySharedPreferences.long,
                          address: MySharedPreferences.address,
                          context: context,
                        )
                            .whenComplete(
                          () {
                            controller.updateUserData(
                              dataBody: addressData,
                              context: context,
                            );
                          },
                        );
                      }
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 6) {
                    if (controller.isImageAdded.value) {
                      controller.updateUserImage(
                          profileImage: controller.image, context: context);
                    }
                  } else if (MySharedPreferences.formCurrentIndex == 7) {
                    if (MySharedPreferences.isDoctor) {
                      MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
                      Get.offAll(() => const DoctorBaseNavBar(),
                          binding: DoctorBaseNavBarBinding());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getButtonTitle() {
    if (MySharedPreferences.lastScreen == 'BaseNavBar') {
      if (MySharedPreferences.formCurrentIndex != forms.length - 1) {
        return 'Next'.tr;
      } else {
        return 'Finish'.tr;
      }
    } else {
      if (MySharedPreferences.formCurrentIndex != forms.length - 1) {
        return 'Next'.tr;
      } else {
        return 'Finish'.tr;
      }
    }
  }
}
