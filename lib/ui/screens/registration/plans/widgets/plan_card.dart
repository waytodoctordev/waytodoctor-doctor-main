import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class PlanCard extends StatelessWidget {
  final String content;
  // final String price;
  final String planId;
  final int daysOfPlan;
  const PlanCard({
    super.key,
    required this.content,
    // required this.price,
    required this.planId,
    required this.daysOfPlan,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlansCtrl>(
      builder: (controller) => Container(
        // height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 37),
        padding: const EdgeInsets.only(right: 0, left: 0, top: 20),
        decoration: BoxDecoration(
          color: MyColors.blue14B,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: MyColors.white,
              ),
            ),
            const Spacer(),
            Material(
              color: Colors.transparent,
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: r'$',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: MyColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: controller.price.toStringAsFixed(2),
                      style: GoogleFonts.tajawal(
                        fontSize: 52,
                        color: MyColors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              title: 'subscription'.tr,
              width: double.maxFinite,
              color: const Color(0xFF14B9D1),
              onPressed: () {
                if (controller.isActive == 1) {
                  controller.checkout(
                      planId: planId,
                      context: context,
                      amount: controller.price.toStringAsFixed(2),
                      daysOfPlan: daysOfPlan);
                } else if (controller.isActive == 0) {
                  AppConstants().showMsgToast(context, msg: 'Currently unavailable'.tr);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
