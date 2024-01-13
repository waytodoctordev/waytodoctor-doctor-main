import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class ProfilePicture extends StatelessWidget {
   ProfilePicture({
    super.key,
  });
   FormCtrl formCtrl =Get.put(FormCtrl());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),//const BouncingScrollPhysics(
          // parent: AlwaysScrollableScrollPhysics()),
        children: [
          Text(
            'Profile photo'.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Please attach a clear profile photo.'.tr,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => formCtrl.getFile(context),
                child:Obx(()=> CircleAvatar(
                  radius: 60,
                  backgroundColor: MyColors.blue14B.withOpacity(0.1),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: formCtrl.profileImage.value!=''
                            ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(formCtrl.image),
                          backgroundColor: MyColors.blue14B,
                        )
                            : Image.asset(
                          MyImages.blankProfile,
                          fit:BoxFit.fill ,
                        ),
                      ),
                      Positioned(
                        left: Get.height*.002,
                        bottom: Get.height*.007,
                        child: CircleAvatar(
                          backgroundColor: MyColors.blue14B,
                          radius: 12,
                          child: SvgPicture.asset(
                            MyIcons.clip,
                            height: 10,
                            width: 10,
                            color: MyColors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),),
              ),
              const SizedBox(height: 5),
             Obx(()=> Text(
                formCtrl.profileImage.value==''
                   ? ''
                   : formCtrl.image.path.split('/').last,
               textAlign: TextAlign.center,
               style: const TextStyle(
                 fontSize: 14,
                 color: MyColors.textColor,
                 fontWeight: FontWeight.w600,
               ),
             ),),
            ],
          ),
        ],
      ),
    );
  }
}
