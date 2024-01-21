import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/specialization_ctrl.dart';

import '../../../../api/logout/logout_api.dart';
import '../../../../binding/registration/registration_binding.dart';
import '../../../../controller/for_doctor/doctor_home_screen/edit_accountr_ctrl.dart';
import '../../../../controller/form/form_ctrl.dart';
import '../../../../utils/api_url.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/images.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../for_doctor/home/edit_account_screen.dart';
import '../../registration/registration/registration_screen.dart';

class CenterHomeBar extends StatelessWidget {
  CenterHomeBar({super.key});
  FormCtrl formCtrl = Get.put(FormCtrl());
  SpecializationCtrl specializationCtrl= Get.put(SpecializationCtrl());
  EditAccountCtrl editAccountCtrl= Get.put(EditAccountCtrl());
bool isEditCenterInfo=false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CenterCtrl>(
      builder: (controller) => Stack(
        // alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 37, right: 37, top: 30),
            child: SizedBox(
              width: Get.width,
              height: Get.height * .17,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// Profile Image
                  GestureDetector(
                    onTap: () async {

                     formCtrl.editProfileImage(
                         context:context,
                         name: editAccountCtrl.nameCtrl.text,
                       professionalLicense:  specializationCtrl.professionalLicense,
                       phone: editAccountCtrl.phoneNumberCtrl.text,
                       address: '${formCtrl.currentCountry}'
                           '|${formCtrl.currentCity}'
                           '|${formCtrl.addressCtrl.text}',
                     );
                      } ,
                    child: CircleAvatar(
                      radius: Get.width * .110,
                      backgroundColor: MyColors.blue14B.withOpacity(0.1),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          MySharedPreferences.userImage
                              .isNotEmpty || formCtrl.profileImage.value!=''
                              ?  ClipOval(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child:
                                CachedNetworkImage(
                                    width: Get.width, // Adjust the size as needed
                                    height: Get.height,
                                    fit: BoxFit.cover,
                                    imageUrl: '${ApiUrl.mainUrl}/${MySharedPreferences.userImage}'),


                          )
                              : Image.asset(
                            MyImages.blankProfile,
                            fit: BoxFit.fill,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CircleAvatar(
                              backgroundColor: MyColors.blue14B,
                              radius: 15,
                              child: Center(
                                child: SvgPicture.asset(
                                  MyIcons.clip,
                                  height: 12,
                                  width: 12,
                                  color: MyColors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ),
                  SizedBox(width: Get.width * .04),
                  /// Greeting
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.greeting(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: MyColors.blue14B,
                          ),
                        ),
                        Text(
                          MySharedPreferences.fName,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                            color: MyColors.blue14B,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// SignOut + Edit Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Edit Account
                      GestureDetector(
                        onTap: () {
                          // print(MySharedPreferences.language);
                          Get.to(() => const EditAccountScreen());
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: MyColors.blue1F6.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgPicture.asset(
                              MyIcons.settings,
                              color: MyColors.blue14B,
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      /// SignOut
                      GestureDetector(
                        onTap: () {
                          Logout().logout();
                          MySharedPreferences.clearProfile();
                          Get.deleteAll(force: true);
                          Get.offAll(
                            () => const RegistrationScreen(),
                            binding: RegestirationBinding(),
                          );
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: MyColors.blue1F6.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgPicture.asset(
                              MyIcons.signOut,
                              color: MyColors.blue14B,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//                 GestureDetector(
//                   onTap: () {
//                     print(MySharedPreferences.userImage);
//                     formCtrl.getFile(context);
//                       // controller.zoomDrawerController.toggle!(
//                       // forceToggle: true);
//                   },
//                   child:
// // CircleAvatar(
// //                     radius: 30,
// //                     backgroundColor: MyColors.blue14B.withOpacity(0.2),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(6.0),
// //                       child: MySharedPreferences.userImage.isNotEmpty
// //                           ? CustomNetworkImage(
// //                         url: MySharedPreferences.userImage,
// //                         radius: 200,
// //                         boxFit: BoxFit.cover,
// //                       )
// //                           : Image.asset(
// //                         MyImages.blankProfile,
// //                       ),
// //                     ),
// //                   ),
//                 ),