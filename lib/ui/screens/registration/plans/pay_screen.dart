// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';
// import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/pay_card.dart';
// import 'package:way_to_doctor_doctor/utils/colors.dart';

// class PayScreen extends StatelessWidget {
//   final String planId;
//   const PayScreen({super.key, required this.planId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Subscriptions'.tr,
//         ),
//       ),
//       body: GetBuilder<PlansCtrl>(
//         builder: (controller) => ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 37),
//               child: Text(
//                 'Choose the subscription that suits you'.tr,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: MyColors.blue14B,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             SizedBox(
//               // height: 500,
//               child: PayCard(
//                 content: controller.plans[controller.currentIndex]!.details!,
//                 price: controller.plans[controller.currentIndex]!.price!,
//                 planId:
//                     controller.plans[controller.currentIndex]!.id.toString(),
//                 daysOfPlan: controller.plans[controller.currentIndex]!.time!,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
