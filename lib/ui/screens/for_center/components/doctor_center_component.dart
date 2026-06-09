import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/custom_shimmer_loading.dart';
import '../../../widgets/doctor_card.dart';
import '../../for_doctor/edit_profile/edit_profile_screen.dart';

class CenterDoctorsComponent extends StatefulWidget {
  const CenterDoctorsComponent({
    super.key,
  });

  @override
  State<CenterDoctorsComponent> createState() => _DoctorCenterComponentState();
}

class _DoctorCenterComponentState extends State<CenterDoctorsComponent> {
  final CenterCtrl controller = Get.find<CenterCtrl>();

  @override
  Widget build(BuildContext context) {
    RxBool isActive = false.obs;
    return GetBuilder<CenterCtrl>(
      init: CenterCtrl(),
      builder: (controller) {
        return controller.centerDoctorsLength
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: Get.height >= 600 ? .80 : .62,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: .00,
                    ), itemCount: controller.doctorsCentersModel!.data!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print( controller.doctorsCentersModel!
                                  .data![index].id.toString());
                              Get.to(
                                      () => DoctorDetailsScreen(
                                    doctorId: controller.doctorsCentersModel!.data![index].id.toString(),
                                  ),
                                 );
                              // if (MySharedPreferences.id != 0) {
                              //
                              //   Get.to(
                              //           () => DoctorDetailsScreen(
                              //         doctorId:  controller.doctorsCentersModel!
                              //               .data![index].id.toString()));
                              //
                              //       // binding: DoctorDetailsBinding());
                              // } else {
                              //   AppConstants()
                              //       .showLoginFirstToast(context);
                              // }
                            },
                            child: DoctorCard(
                              image: controller
                                  .doctorsCentersModel!.data![index].image
                                  .toString(),
                              name: controller
                                  .doctorsCentersModel!.data![index].name
                                  .toString(),
                              categoryName: controller.doctorsCentersModel!
                                  .data![index].categoryName
                                  .toString(),
                              rating: controller
                                  .doctorsCentersModel!.data![index].rating!
                                  .toDouble(),
                            ),
                          ),
                          // const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: Transform.scale(
                              scale: 0.70,
                              child: Switch(
                                value: controller.doctorsCentersModel!
                                    .data![index].centerStatus,
                                activeThumbColor: MyColors.greenc4e,
                                activeTrackColor: MyColors.grey5d8,
                                inactiveThumbColor: MyColors.secondary,
                                onChanged: (bool value) {
                                  isActive.value = value;
                                  controller.changeActivityStatusRequest(
                                    doctorId: controller
                                        .doctorsCentersModel!.data![index].id
                                        .toString(),
                                    activityStatus: value,
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
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Get.height >= 600 ? 1 : .64,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 8,
                ),
                padding: const EdgeInsets.only(left: 37, right: 37, bottom: 60),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const CustomShimmerLoading(
                    radius: 24,
                  );
                },
              );
      },
    );
  }
}
//FutureBuilder(
//             future: DoctorsCenterCtrl.find.initializeDoctorCenterFuture,
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: Get.height >= 600 ? 1 : .64,
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 18,
//                       mainAxisSpacing: 8,
//                     ),
//                     padding:
//                         const EdgeInsets.only(left: 37, right: 37, bottom: 60),
//                     itemCount: 12,
//                     itemBuilder: (context, index) {
//                       return const CustomShimmerLoading(
//                         radius: 24,
//                       );
//                     },
//                   );
//                 case ConnectionState.done:
//                 default:
//                   if (snapshot.data != null) {
//                     if (snapshot.data!.data!.isEmpty) {
//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         child: Center(
//                           child: Text(
//                             AppConstants.noItems,
//                             style: const TextStyle(color: MyColors.blue14B),
//                           ),
//                         ),
//                       );
//                     }
//
//                     if (snapshot.hasData) {
//                       return Center(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 25),
//                           child: GridView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               childAspectRatio: Get.height >= 600 ? .80 : .62,
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 2,
//                               mainAxisSpacing: .00,
//                             ),
//                             // padding:  EdgeInsets.symmetric(horizontal: Get.height*.02),
//                             itemCount: controller.doctorsCentersModel == null
//                                 ? 0
//                                 : controller.doctorsCentersModel!.data!.length,
//                             itemBuilder: (context, index) {
//                               return Stack(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.to(
//                                               () => DoctorDetailsScreen(
//                                             doctorId: snapshot
//                                                 .data!.data![index].id
//                                                 .toString(),
//                                           ),
//                                           binding: DoctorDetailsBinding());
//                                       // if (MySharedPreferences.id != 0) {
//                                       //   Get.to(
//                                       //           () => DoctorDetailsScreen(
//                                       //         doctorId: snapshot
//                                       //             .data!.data![index].id
//                                       //             .toString(),
//                                       //       ),
//                                       //       binding: DoctorDetailsBinding());
//                                       // } else {
//                                       //   AppConstants()
//                                       //       .showLoginFirstToast(context);
//                                       // }
//                                     },
//                                     child: DoctorCard(
//                                       image: snapshot.data!.data![index].image
//                                           .toString(),
//                                       name: snapshot.data!.data![index].name
//                                           .toString(),
//                                       categoryName: snapshot
//                                           .data!.data![index].categoryName
//                                           .toString(),
//                                       rating: snapshot
//                                           .data!.data![index].rating!
//                                           .toDouble(),
//                                     ),
//                                   ),
//                                   // const SizedBox(width: 10),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 30.0,),
//                                     child: Transform.scale(
//                                       scale: 0.70,
//                                       child: Switch(
//                                         value: snapshot
//                                             .data!.data![index].centerStatus,
//                                         activeColor: MyColors.greenc4e,
//                                         activeTrackColor: MyColors.grey5d8,
//                                         inactiveThumbColor:
//                                         MyColors.secondary,
//                                         onChanged: (bool value) {
//                                           isActive.value = value;
//                                           controller.changeActivityStatusRequest(
//                                             doctorId:snapshot
//                                                 .data!.data![index].id
//                                                 .toString(),
//                                             activityStatus: value,
//                                             context: context,
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const FailedWidget();
//                     }
//                   } else {
//                     return GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: Get.height >= 600 ? 1 : .64,
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 18,
//                         mainAxisSpacing: 8,
//                       ),
//                       padding: const EdgeInsets.only(
//                           left: 37, right: 37, bottom: 60),
//                       itemCount: 12,
//                       itemBuilder: (context, index) {
//                         return const CustomShimmerLoading(
//                           radius: 24,
//                         );
//                       },
//                     );
//                   }
//               }
//             });
