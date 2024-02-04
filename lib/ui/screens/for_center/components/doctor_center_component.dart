import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:way_to_doctor/binding/doctor_details/doctor_details_binding.dart';
// import 'package:way_to_doctor/ui/screen/doctor_details/doctor_details_screen.dart';
// import 'package:way_to_doctor/ui/widgets/custom_shimmer_loading.dart';
// import 'package:way_to_doctor/ui/widgets/failed_widget.dart';
// import 'package:way_to_doctor/utils/app_constants.dart';
// import 'package:way_to_doctor/utils/colors.dart';
// import '../../../../controller/centers/doctors_center_ctrl.dart';
// import '../../../../model/centers/center_model.dart';
import '../../../../binding/for_doctor/doctor_details/doctor_details_binding.dart';
import '../../../../controller/for_center/doctors_center_ctrl.dart';
import '../../../../model/center/center_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/custom_shimmer_loading.dart';
import '../../../widgets/doctor_card.dart';
import '../../../widgets/failed_widget.dart';
import '../../for_doctor/edit_profile/edit_profile_screen.dart';

class DoctorCenterComponent extends StatelessWidget {
  // final Centers centerInfo;
   DoctorCenterComponent({
    super.key,
  }); //required this.centerInfo
  DoctorsCenterCtrl controller = Get.put(DoctorsCenterCtrl());

  @override
  Widget build(BuildContext context) {
    RxBool isActive = false.obs;
    return GetBuilder<DoctorsCenterCtrl>(
      init: DoctorsCenterCtrl(),
      builder: (controller) {
        return FutureBuilder(
            future: DoctorsCenterCtrl.find.initializeDoctorCenterFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: Get.height >= 600 ? 1 : .64,
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 8,
                    ),
                    padding:
                        const EdgeInsets.only(left: 37, right: 37, bottom: 60),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return const CustomShimmerLoading(
                        radius: 24,
                      );
                    },
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.data != null) {
                    if (snapshot.data!.data!.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Center(
                          child: Text(
                            AppConstants.noItems,
                            style: const TextStyle(color: MyColors.blue14B),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: Get.height >= 600 ? .80 : .62,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: .00,
                            ),
                            // padding:  EdgeInsets.symmetric(horizontal: Get.height*.02),
                            itemCount: controller.doctorsCentersModel == null
                                ? 0
                                : controller.doctorsCentersModel!.data!.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                              () => DoctorDetailsScreen(
                                            doctorId: snapshot
                                                .data!.data![index].id
                                                .toString(),
                                          ),
                                          binding: DoctorDetailsBinding());
                                      // if (MySharedPreferences.id != 0) {
                                      //   Get.to(
                                      //           () => DoctorDetailsScreen(
                                      //         doctorId: snapshot
                                      //             .data!.data![index].id
                                      //             .toString(),
                                      //       ),
                                      //       binding: DoctorDetailsBinding());
                                      // } else {
                                      //   AppConstants()
                                      //       .showLoginFirstToast(context);
                                      // }
                                    },
                                    child: DoctorCard(
                                      image: snapshot.data!.data![index].image
                                          .toString(),
                                      name: snapshot.data!.data![index].name
                                          .toString(),
                                      categoryName: snapshot
                                          .data!.data![index].categoryName
                                          .toString(),
                                      rating: snapshot
                                          .data!.data![index].rating!
                                          .toDouble(),
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                                    child: Transform.scale(
                                      scale: 0.70,
                                      child: Switch(
                                        value: snapshot
                                            .data!.data![index].centerStatus,
                                        activeColor: MyColors.greenc4e,
                                        activeTrackColor: MyColors.grey5d8,
                                        inactiveThumbColor:
                                        MyColors.secondary,
                                        onChanged: (bool value) {
                                          isActive.value = value;
                                          controller.changeActivityStatusRequest(
                                            doctorId:snapshot
                                                .data!.data![index].id
                                                .toString(),
                                            centerStatus: value,
                                            context: context,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const FailedWidget();
                    }
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: Get.height >= 600 ? 1 : .64,
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 8,
                      ),
                      padding: const EdgeInsets.only(
                          left: 37, right: 37, bottom: 60),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return const CustomShimmerLoading(
                          radius: 24,
                        );
                      },
                    );
                  }
              }
            });
      },
    );
  }
}
