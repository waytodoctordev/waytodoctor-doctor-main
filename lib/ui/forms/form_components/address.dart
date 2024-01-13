import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/map.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class Address extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  UserLocationCtrl userLocationCtrl = Get.put(UserLocationCtrl());
  // FormCtrl formCtrl = Get.put(FormCtrl());
   Address({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormCtrl>(
      builder: (controller) {
        return Form(
          key: formKey,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
          // const BouncingScrollPhysics(
          //       parent: AlwaysScrollableScrollPhysics()),
            children: [
              Text(
                'Address :'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(MySharedPreferences.isDoctor
                  ? 'Specify the address of your clinic'.tr
                  : 'Specify the address of your center'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              MySharedPreferences.isDoctor
                  ? GestureDetector(
                onTap: () => Get.to(() =>  MapScreen()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(MyImages.address, height: 120),
                ),
              ):SizedBox(),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 150),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  hintText: controller.currentCountry,
                  horizontalPadding: 16,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Get.back(),
                            // isDefaultAction: true,
                            child: Text(
                              'Cancel'.tr,
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: MyColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          actions: [
                            SizedBox(
                              height: 250,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  controller.getCurrentCountry(controller
                                      .countries![value].name
                                      .toString());
                                  controller.getcitiesList(
                                      countryId: controller.countries![value].id
                                          .toString());
                                },
                                itemExtent: 28.0,
                                children: controller.countries!.map(
                                  (item) {
                                    return Center(
                                      child: Text(
                                        item.name.toString(),
                                        style: GoogleFonts.tajawal(
                                          fontSize: 16,
                                          color: MyColors.blue14B,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  suffixIcon: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 14,
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  hintText: controller.currentCity,
                  horizontalPadding: 16,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Get.back(),
                            // isDefaultAction: true,
                            child: Text(
                              'Cancel'.tr,
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: MyColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          actions: [
                            SizedBox(
                              height: 250,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  controller.getCurrentCity(
                                    controller.cities![value].name.toString(),
                                  );
                                },
                                itemExtent: 28.0,
                                children: controller.cities!.map(
                                  (item) {
                                    return Center(
                                      child: Text(
                                        item.name.toString(),
                                        style: GoogleFonts.tajawal(
                                          fontSize: 16,
                                          color: MyColors.blue14B,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  suffixIcon: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 14,
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  controller: controller.addressCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your address details".tr;
                    }
                    if (value.length < 4) {
                      return 'Address details too short'.tr;
                    }
                    return null;
                  },
                  hintText: 'Address details'.tr,
                  horizontalPadding: 16,
                  onTap: () {
                    printInfo();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
