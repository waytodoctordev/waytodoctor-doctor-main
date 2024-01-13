import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/user_doctors_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/doctors_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/doctor_card.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

import '../../../../../model/user_other_doctors/user_other_doctors_model.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/my_other_doctor_component.dart';
import '../../../../widgets/vertical_loading.dart';

class PatientDoctorsComponent extends StatefulWidget {
  final String userId;
  const PatientDoctorsComponent({super.key, required this.userId});

  @override
  State<PatientDoctorsComponent> createState() =>
      _PatientDoctorsComponentState();
}

class _PatientDoctorsComponentState extends State<PatientDoctorsComponent> {
  @override
  void initState() {
    Get.put(UserDoctorsCtrl());
    UserDoctorsCtrl.find.userId = widget.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<UserDoctorsCtrl>(
      builder: (controller) => Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomElevatedButton(
                        title: controller.titles[index],
                        fontWeight: FontWeight.normal,
                        height: 50,
                        textSize: 14,
                        width: 120,
                        color: controller.currentIndex != index
                            ? MyColors.grey7f8
                            : MyColors.blue14B,
                        textColor: controller.currentIndex != index
                            ? MyColors.blue14B
                            : MyColors.white,
                        onPressed: () {
                          controller.getCurrentIndex(index);

                          if (controller.currentIndex == 0) {
                            controller.pagingController.refresh();
                          }

                          if (controller.currentIndex == 1) {
                            controller.otherDoctorsPagingController.refresh();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          controller.currentIndex == 0
              ? Expanded(
                  child: PagedGridView(
                    padding: const EdgeInsets.only(
                        left: 37, right: 37, bottom: 80, top: 10),
                    physics: const BouncingScrollPhysics(),
                    pagingController: controller.pagingController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: size.height >= 600 ? .7 : .65,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 0,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<Doctors>(
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            AppConstants.noItems,
                            style: const TextStyle(color: MyColors.blue14B),
                          ),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return const LoadingIndicator();
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return const LoadingIndicator();
                      },
                      itemBuilder: (context, data, index) {
                        return DoctorCard(
                          categoryName: data.categoryName.toString(),
                          image: data.image.toString(),
                          name: data.name.toString(),
                          rating: data.rating!.toDouble(),
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: PagedListView<int, OtherDoctorsData>.separated(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(bottom: 120, right: 37, left: 37),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    pagingController: controller.otherDoctorsPagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            AppConstants.noItems,
                            style: const TextStyle(color: MyColors.blue14B),
                          ),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 50),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (BuildContext context, int index) {
                              return const BaseVerticalListLoading();
                            },
                          ),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return const LoadingIndicator();
                      },
                      itemBuilder: (context, item, index) {
                        return MyOtherDoctorsComponent(doctor: item);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
