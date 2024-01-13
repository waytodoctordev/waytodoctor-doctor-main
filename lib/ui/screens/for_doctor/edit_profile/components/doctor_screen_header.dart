import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/edit_experimce_dialog.dart';

import '../../../../../binding/for_doctor/rating/rating_binding.dart';
import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/icons.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../categories/categories_screen.dart';
import '../../ratings/rating_screen.dart';

class DoctorScreenHeader extends StatelessWidget {
  final DoctorDetailsModel? doctorDetails;

  const DoctorScreenHeader({
    super.key,
    this.doctorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsCtrl>(
      builder: (controller) => Column(
        children: [
          GestureDetector(
            onTap: () async =>
                await controller.getProfileImage(context: context),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: CustomNetworkImage(
                    url: doctorDetails!.data!.image.toString(),
                    radius: 26,
                    height: 125,
                    width: 125,
                  ),
                ),
                Container(
                  height: 125,
                  width: 125,
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: MyColors.grey5d8.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(26)),
                  child: SvgPicture.asset(
                    MyIcons.edit,
                    height: 8,
                    width: 8,
                    color: MyColors.blue14B,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
              onTap: () {
                Get.to(() => const CategoriesScreen());
              },
              child: doctorDetails!.data!.categoryName!.isNotEmpty
                  ? Text(
                      doctorDetails!.data!.categoryName.toString(),
                      // doctor.address.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      'Categories'.tr,
                      // doctor.address.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Patients'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: MyColors.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doctorDetails!.data!.userCount.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: MyColors.blue1dd4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(color: MyColors.blue1dd4, width: 5),
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const EditExperinceDialog(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Experience'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: MyColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        MySharedPreferences.language != 'en'
                            ? '${doctorDetails!.data!.experience.toString()} سنة'
                            : '${doctorDetails!.data!.experience.toString()} years',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: MyColors.blue1dd4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(color: MyColors.blue1dd4, width: 5),
                GestureDetector(
                  onTap: () => Get.to(
                      () => DoctorRatingScreen(
                          doctorId: doctorDetails!.data!.id.toString()),
                      binding: RatingsBinding()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rating'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: MyColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 3, left: 3),
                            child: Text(
                              double.parse((doctorDetails!.data!.rating)!
                                      .toStringAsFixed(1))
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: MyColors.blue1dd4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            MyIcons.star,
                            height: 13,
                            width: 13,
                            color: MyColors.yellowf03,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
