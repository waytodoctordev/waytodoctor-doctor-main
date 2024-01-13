import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/plans/plans_binding.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/current_plan/current_plan_ctrl.dart';
import 'package:way_to_doctor_doctor/model/subscription_model/subscription_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/plans_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CurrentPlanScreen extends StatefulWidget {
  const CurrentPlanScreen({super.key});

  @override
  State<CurrentPlanScreen> createState() => _CurrentPlanScreenState();
}

class _CurrentPlanScreenState extends State<CurrentPlanScreen> {
  @override
  void initState() {
    Get.put(CurrentPlanCtrl());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: MySharedPreferences.language == 'ar'
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(270 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                )
              : RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                ),
        ),
        leadingWidth: 80,
        title: Text(
          'Current Subscription'.tr,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GetBuilder<CurrentPlanCtrl>(
              builder: (controller) => Expanded(
                  child: FutureBuilder<SubscriptionModel?>(
                future: controller.initializeCurrentPlanFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const LoadingIndicator();
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        DateTime endDate = DateTime.parse(
                            snapshot.data!.data.endDate.toString());
                        final days = endDate.difference(DateTime.now()).inDays;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // alignment: Alignment.center,
                              height: 300,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 37),
                              padding: const EdgeInsets.only(
                                  right: 0, left: 0, top: 20),
                              decoration: BoxDecoration(
                                color: MyColors.blue14B,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.data.plan.details.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: MyColors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    days <= 0 ? '' : days.toString(),
                                    style: const TextStyle(
                                      fontSize: 52,
                                      color: MyColors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    days <= 0
                                        ? 'Subscription available until the end of the day'
                                            .tr
                                        : 'remaining '.tr,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: MyColors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomElevatedButton(
                                    title: 'Renew'.tr,
                                    width: double.maxFinite,
                                    color: const Color(0xFF14B9D1),
                                    onPressed: () {
                                      Get.to(() => const PlansScreen(),
                                          binding: PlansBinding());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const FailedWidget();
                      }
                  }
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
