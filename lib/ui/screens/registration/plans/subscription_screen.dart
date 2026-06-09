// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:way_to_doctor_doctor/binding/registration/check_participate_binding.dart';
// import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';
// import 'package:way_to_doctor_doctor/services/store_kit_bridge.dart';
// import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/check_practice_screen.dart';
// import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/subscription_card.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
// import 'package:way_to_doctor_doctor/utils/colors.dart';
// import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
// import '../../../../binding/privcy/policies_binding.dart';
// import '../../../../controller/registration/sign_in_ctrl.dart';
// import '../../../../utils/icons.dart';
// import '../../../../utils/images.dart';
// import '../../../base/for_doctor/no_need/privcy_screen.dart';
// import '../../../base/for_doctor/no_need/terms_screen.dart';
//
// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});
//
//   @override
//   State<SubscriptionScreen> createState() => _PlansScreenState();
// }
//
// class _PlansScreenState extends State<SubscriptionScreen> {
//   // TextEditingController copounCtrl = TextEditingController();
//   final PlansCtrl plansCon = Get.put(PlansCtrl());
//   SignInCtrl signin = Get.put(SignInCtrl());
//   List<StoreProduct>? products;
//   // List<Map<String, String>> subscriptionsData = [
//   //   {
//   //     'name': 'Monthly Subscription',
//   //     'price': '14.99 / ${'month'.tr}',
//   //     'id': 'Premium_Monthly_Subscription'
//   //   },
//   //   {
//   //     'name': 'Yearly subscription',
//   //     'price': '179.99 / ${'year'.tr}',
//   //     'id': 'Premium_Annual_Subscription',
//   //   }
//   // ];
//   @override
//   void initState() {
//     getProducts();
//     super.initState();
//   }
//
//   getProducts() async {
//     products = await Purchases.getProducts(['premuim']);
//     log('products =${products.toString()}');
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: SafeArea(
//       child: Stack(
//         children: [
//           SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: Image.asset(
//               MyImages.loginImage,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: Get.height * .02),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     signin.goBack.value
//                         ? Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: Get.height * .02,
//                               vertical: 30,
//                             ),
//                             child: GestureDetector(
//                               child: RotatedBox(
//                                 quarterTurns:
//                                     MySharedPreferences.language == 'ar'
//                                         ? 3
//                                         : 5, // Rotate only for Arabic
//                                 child: SvgPicture.asset(
//                                   MyIcons.angleSmallRight,
//                                   color: MyColors.blue14B,
//                                 ),
//                               ),
//                               onTap: () => Get.back(),
//                             ),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 30, horizontal: 40),
//                           ),
//                     SizedBox(
//                       width: Get.width * .22,
//                     ),
//                     Text(
//                       'Subscriptions'.tr,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: MyColors.blue14B,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 37),
//                       child: Center(
//                         child: Text(
//                           'Choose the subscription that suits you'.tr,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             color: MyColors.blue14B,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ListView(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.only(bottom: 20),
//                       children: [
//                         /// MONTHLY AND YEARLY BUTTONS
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:
//                               List.generate(products!.length, (index) {
//                             return Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     controller.pageCtrl.jumpToPage(index);
//                                     controller.getCurrentIndex(index);
//                                     print('index $index');
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 17, vertical: 22),
//                                     decoration: BoxDecoration(
//                                       color: controller.currentIndex != index
//                                           ? MyColors.blue9D1
//                                           : MyColors.blue14B,
//                                       borderRadius: BorderRadius.circular(24),
//                                     ),
//                                     child: Text(
//                                       products![index].title.tr,
//                                       style: TextStyle(
//                                           color:
//                                               controller.currentIndex != index
//                                                   ? MyColors.blue14B
//                                                   : MyColors.white,
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 15),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                               ],
//                             );
//                           }),
//                         ),
//
//                         /// SUBSCRIPTION BODY CONTAINER
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           height: 300,
//                           width: MediaQuery.of(context).size.width,
//                           child: PageView(
//                             physics: const BouncingScrollPhysics(
//                                 parent: AlwaysScrollableScrollPhysics()),
//                             scrollDirection: Axis.horizontal,
//                             controller: controller.pageCtrl,
//                             // children: List.generate(
//                             //   controller.plans.length,
//                             //   (index) => PlanCard(
//                             //     content: controller
//                             //         .plans[controller.currentIndex]!
//                             //         .details!,
//                             //     // price: controller
//                             //     //     .plans[controller.currentIndex]!.price!,
//                             //     planId: controller
//                             //         .plans[controller.currentIndex]!.id
//                             //         .toString(),
//                             //     daysOfPlan: controller
//                             //         .plans[controller.currentIndex]!.time!,
//                             //   ),
//                             // ),
//                             children: List.generate(
//                               products!.length,
//                               (index) => SubscriptionCard(
//                                 subscriptionId: products![index].identifier,
//                                 subscriptionName: products![index].title,
//                                 subscriptionPrice: products![index].price.toString(),
//                               ),
//                             ),
//                             onPageChanged: (index) {
//                               controller.getCurrentIndex(index);
//                               controller.getCurrentPrice(
//                                   double.parse(controller
//                                   .plans[controller.currentIndex]!.price!));
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Get.width * .15),
//                             child: CustomElevatedButton(
//                               title: 'redeem coupon'.tr,
//                               // width: double.maxFinite,
//                               // color:  MyColors.white,
//                               onPressed: () {
//                                 MySharedPreferences.reNewSub = true;
//                                 print(MySharedPreferences.reNewSub);
//                                 print('opend ');
//                                 StoreKitBridge.presentCodeRedemptionSheet();
//                               },
//                             )),
//                         SizedBox(height: Get.height * .2),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () => Get.to(() => const PrivcyScreen(),
//                                   binding: PoliciesBinding()),
//                               child: Text(
//                                 'Privacy policy'.tr,
//                                 style: const TextStyle(
//                                   color: MyColors.blue14B,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () => Get.to(() => const TermsScreen(),
//                                   binding: PoliciesBinding()),
//                               child: Text(
//                                 'Terms and Conditions'.tr,
//                                 style: const TextStyle(
//                                   color: MyColors.blue14B,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                         // Padding(
//                         //   padding: const EdgeInsets.only(
//                         //       left: 40, right: 40, top: 30, bottom: 10),
//                         //   child: Text(
//                         //     "Do you have a discount coupon?".tr,
//                         //     style: const TextStyle(
//                         //         fontWeight: FontWeight.bold,
//                         //         color: MyColors.blue14B),
//                         //   ),
//                         // ),
//                         // Form(
//                         //   key: copounKey,
//                         //   child: Padding(
//                         //     padding:
//                         //         const EdgeInsets.only(left: 40, right: 40),
//                         //     child: CustomTextField(
//                         //       textInputAction: TextInputAction.next,
//                         //       controller: copounCtrl,
//                         //       hintText:'COUPON'.tr,
//                         //       horizontalPadding: 20,
//                         //       validator: (value) {
//                         //         if (value!.isEmpty) {
//                         //           return "".tr;
//                         //         }
//                         //         if (value.length < 4) {
//                         //           return ''.tr;
//                         //         }
//                         //         return null;
//                         //       },
//                         //       maxSuffixWidth: 100,
//                         //       minSuffixWidth: 20,
//                         //       suffixIcon: Padding(
//                         //         padding: const EdgeInsets.all(8.0),
//                         //         child: TextButton(
//                         //           onPressed: () {
//                         //             if (copounKey.currentState!
//                         //                 .validate()) {
//                         //               if (!controller.isCopounAdded) {
//                         //                 controller.fetchCopoun(
//                         //                     context: context,
//                         //                     copounName: copounCtrl.text);
//                         //               } else {
//                         //                 controller
//                         //                     .getPriceWithoutDiscount();
//                         //                 // copounCtrl.text = '';
//                         //               }
//                         //             }
//                         //           },
//                         //           child: Text(
//                         //             !controller.isCopounAdded
//                         //                 ? 'Add'.tr
//                         //                 : 'Delete'.tr,
//                         //             style: TextStyle(
//                         //                 color: !controller.isCopounAdded
//                         //                     ? MyColors.blue14B
//                         //                     : MyColors.red101),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     // const Text('إضافة كوبون خصم'),
//                     controller.isActive == 1
//                         ? const SizedBox()
//                         : controller.isActive == 0 &&
//                                 MySharedPreferences.lastScreen !=
//                                     'DoctorBaseNavBar'
//                             ? Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 37, vertical: 20),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         MySharedPreferences.language == 'ar'
//                                             ? 'خدمة الإشتراك موقوفة لمساء يوم الخميس الموافق 23-2-2023'
//                                             : 'The subscription service is suspended for the evening of Thursday, 23-2-2023',
//                                         textAlign: TextAlign.center,
//                                         style: const TextStyle(
//                                           color: MyColors.blue14B,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 20),
//                                       CustomElevatedButton(
//                                         title: 'Skip'.tr,
//                                         onPressed: () {
//                                           Get.to(
//                                               () => const CheckPracticeScreen(),
//                                               binding: CheckPracticeBinding());
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ));
//   }
// }
