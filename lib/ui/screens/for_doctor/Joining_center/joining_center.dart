import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';

import '../../../../model/categories/categories_model.dart';
import '../../../../model/center/category_centers.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/custom_elevated_button.dart';

class JoiningCenter extends StatefulWidget {
  JoiningCenter({super.key});

  @override
  State<JoiningCenter> createState() => _JoiningCenterState();
}

class _JoiningCenterState extends State<JoiningCenter> {
  CenterCtrl centerCtrl = Get.put(CenterCtrl());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CenterCtrl.find.getCategoriesList(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joining To Center'.tr),
      ),
      body: SafeArea(
        /// CATEGORIES COMPONENT
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you affiliated with a specific Center?'.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: MyColors.blue14B,
                ),
              ),
              Text(
                'If you want to join or enroll yourself in a center'.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: MyColors.blue14B,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Select a category and center'.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: MyColors.blue14B,
                ),
              ),

              /// CATEGORY CENTERS COMPONENT
              Obx(
                () => centerCtrl.categoriesLength.value
                    ? Column(
                        children: [
                          Obx(
                            () => FadeInDown(
                              from: 6,
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 150),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: MyColors.fillColor,
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(26),
                                  underline: const SizedBox(),
                                  value: centerCtrl.categoriesID.value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: MyColors.blue14B,
                                  ),
                                  itemHeight: 60,
                                  alignment: Alignment.center,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SvgPicture.asset(
                                      MyIcons.angleSmallRight,
                                      height: 7,
                                      width: 14,
                                      color: MyColors.blue14B,
                                    ),
                                  ),
                                  elevation: 1,
                                  items: centerCtrl.categories!.map(
                                    (Categories category) {
                                      return DropdownMenuItem(
                                        value: category.id,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            category.name.toString(),
                                            style: GoogleFonts.tajawal(
                                              fontSize: 18,
                                              color: MyColors.blue14B,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (int? value) {
                                    print(centerCtrl.categoriesID.value);
                                    centerCtrl.categoriesID.value = value!;
                                    MySharedPreferences.centerCategoryID =
                                        value.toString();
                                    MySharedPreferences.isDoctor
                                        ? centerCtrl.getCategoriesCentersList(
                                            context: context)
                                        : null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(
                            () => FadeInDown(
                              from: 6,
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 150),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: MyColors.fillColor,
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(26),
                                  underline: const SizedBox(),
                                  value: centerCtrl.centerID.value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: MyColors.blue14B,
                                  ),
                                  itemHeight: 60,
                                  alignment: Alignment.center,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SvgPicture.asset(
                                      MyIcons.angleSmallRight,
                                      height: 7,
                                      width: 14,
                                      color: MyColors.blue14B,
                                    ),
                                  ),
                                  elevation: 1,
                                  items: centerCtrl.categoryCentersList?.map(
                                    (CategoryCentersData center) {
                                      return DropdownMenuItem(
                                        value: center.id,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            center.name.toString(),
                                            style: GoogleFonts.tajawal(
                                              fontSize: 18,
                                              color: MyColors.blue14B,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (int? value) {
                                    print(centerCtrl.centerID.value);
                                    centerCtrl.centerID.value = value!;

                                    // setState(() {
                                    //   MySharedPreferences.isDoctor
                                    //       ? print('yes nancy')
                                    //       : print('no nancy');
                                    // });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : LoadingIndicator(),
              ),
              SizedBox(height: Get.height * 0.3),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Center(
                  child: FadeInDown(
                    from: 6,
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 450),
                    child: CustomElevatedButton(
                      title: 'Joining To Center'.tr,
                      radius: 24,
                      onPressed: () {
                        centerCtrl.joinDoctorToCenter(
                            doctorId: MySharedPreferences.id.toString(),
                            centerId: centerCtrl.centerID.value.toString(),
                            context: context);
                      },
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
