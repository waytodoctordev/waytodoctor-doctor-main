import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/registration/check_participate_binding.dart';
import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';
import 'package:way_to_doctor_doctor/model/plans_model/plans_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/check_practice_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/plan_card.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../utils/icons.dart';
import '../../../widgets/custom_text_field.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  TextEditingController copounCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(PlansCtrl());
  }

  @override
  void dispose() {
    copounCtrl.dispose();
    PlansCtrl.find.price = PlansCtrl.find.actualPrice;
    PlansCtrl.find.price =
        double.parse(PlansCtrl.find.plansModel!.data![0].price!);
    PlansCtrl.find.actualPrice =
        double.parse(PlansCtrl.find.plansModel!.data![0].price!);
    PlansCtrl.find.isCopounAdded = false;
    PlansCtrl.find.currentIndex = 0;
    PlansCtrl.find.discount = 0;
    PlansCtrl.find.couponId = 0;
    PlansCtrl.find.couponType = 'fixed';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> copounKey = GlobalKey<FormState>();
    // Loader.hide();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscriptions'.tr,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: RotatedBox(
            quarterTurns: 3,
            child: SvgPicture.asset(
              MyIcons.angleSmallRight,
              color: MyColors.blue14B,
            ),
          ),
        ),
      ),
      body: GetBuilder<PlansCtrl>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37),
              child: Text(
                'Choose the subscription that suits you'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: FutureBuilder<PlansModel?>(
                future: controller.initializePlansFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const LoadingIndicator();
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 20),
                          children: [
                            /// MONTHLY AND YEARLY BUTTONS
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(controller.plans.length,
                                  (index) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                       controller.pageCtrl.jumpToPage(index);
                                       controller.getCurrentIndex(index);
                                       controller.getCurrentPrice(double.parse(
                                           controller
                                               .plans[controller.currentIndex]!
                                               .price!));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 22),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.currentIndex != index
                                                  ? MyColors.blue9D1
                                                  : MyColors.blue14B,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: Text(
                                          controller.plans[index]!.name
                                              .toString().tr,
                                          style: TextStyle(
                                            color:
                                                controller.currentIndex != index
                                                    ? MyColors.blue14B
                                                    : MyColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              }),
                            ),
                            /// SUBSCRIPTION BODY CONTAINER
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: PageView(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                controller: controller.pageCtrl,
                                children: List.generate(
                                  controller.plans.length,
                                  (index) => PlanCard(
                                    content: controller
                                        .plans[controller.currentIndex]!
                                        .details!,
                                    // price: controller
                                    //     .plans[controller.currentIndex]!.price!,
                                    planId: controller
                                        .plans[controller.currentIndex]!.id
                                        .toString(),
                                    daysOfPlan: controller
                                        .plans[controller.currentIndex]!.time!,
                                  ),
                                ),
                                onPageChanged: (index) {
                                  controller.getCurrentIndex(index);
                                  controller.getCurrentPrice(double.parse(
                                      controller.plans[controller.currentIndex]!
                                          .price!));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 30, bottom: 10),
                              child: Text(
                                "Do you have a discount coupon?".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.blue14B),
                              ),
                            ),
                            Form(
                              key: copounKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: CustomTextField(
                                  textInputAction: TextInputAction.next,
                                  controller: copounCtrl,
                                  hintText:'COUPON'.tr,
                                  horizontalPadding: 20,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "".tr;
                                    }
                                    if (value.length < 4) {
                                      return ''.tr;
                                    }
                                    return null;
                                  },
                                  maxSuffixWidth: 100,
                                  minSuffixWidth: 20,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (copounKey.currentState!
                                            .validate()) {
                                          if (!controller.isCopounAdded) {
                                            controller.fetchCopoun(
                                                context: context,
                                                copounName: copounCtrl.text);
                                          } else {
                                            controller
                                                .getPriceWithoutDiscount();
                                            // copounCtrl.text = '';
                                          }
                                        }
                                      },
                                      child: Text(
                                        !controller.isCopounAdded
                                            ? 'Add'.tr
                                            : 'Delete'.tr,
                                        style: TextStyle(
                                            color: !controller.isCopounAdded
                                                ? MyColors.blue14B
                                                : MyColors.red101),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const FailedWidget();
                      }
                  }
                },
              ),
            ),
            // const Text('إضافة كوبون خصم'),
            controller.isActive == 1
                ? const SizedBox()
                : controller.isActive == 0 &&
                        MySharedPreferences.lastScreen != 'DoctorBaseNavBar'
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 37, vertical: 20),
                          child: Column(
                            children: [
                              Text(
                                MySharedPreferences.language == 'ar'
                                    ? 'خدمة الإشتراك موقوفة لمساء يوم الخميس الموافق 23-2-2023'
                                    : 'The subscription service is suspended for the evening of Thursday, 23-2-2023',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: MyColors.blue14B,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomElevatedButton(
                                title: 'Skip'.tr,
                                onPressed: () {
                                  Get.to(() => const CheckPracticeScreen(),
                                      binding: CheckPracticeBinding());
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
