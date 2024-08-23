import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/edit_account_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorBaseNavBarCtrl>(
      builder: (controller) => Stack(
        // alignment: Alignment.topCenter,
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.only(left: 37, right: 37, top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.zoomDrawerController.toggle!(forceToggle: true),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: MyColors.blue14B.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: MySharedPreferences.userImage.isNotEmpty
                          ? CustomNetworkImage(
                              url: MySharedPreferences.userImage,
                              radius: 200,
                              boxFit: BoxFit.cover,
                            )
                          : Image.asset(
                              MyImages.blankProfile,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
                // const Spacer(),
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
              ],
            ),
          ),
          MySharedPreferences.language == 'ar'
              ? Positioned(
                  right: -35,
                  top: -5,
                  child: GestureDetector(
                    onTap: () {
                      // controller.zoomDrawerController.toggle!(forceToggle: true);
                    },
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      //TODO: Deprecated -- Nancy
                      // child: SvgDrawingAnimation(
                      //   SvgProvider.asset(MyIcons.drawerLine),
                      //   // curve: Curves.easeIn,
                      //   duration: const Duration(seconds: 2),
                      // ),
                    ),
                  ),
                )
              : Positioned(
                  top: -5,
                  left: -35,
                  child: GestureDetector(
                    onTap: () {
                      // controller.zoomDrawerController.toggle!(forceToggle: true);
                    },
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(235 / 360),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        //TODO: Deprecated -- Nancy
                        // child: SvgDrawingAnimation(
                        //   SvgProvider.asset(MyIcons.drawerLine),
                        //   duration: const Duration(seconds: 2),
                        // ),
                      ),
                      // child: Image.asset(
                      //   MyImages.drawer,
                      //   height: 80,
                      //   width: 80,
                      // ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
