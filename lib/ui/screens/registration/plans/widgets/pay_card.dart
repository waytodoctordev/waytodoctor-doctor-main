// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
// import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
// import 'package:way_to_doctor_doctor/utils/app_constants.dart';
// import 'package:way_to_doctor_doctor/utils/colors.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

// class PayCard extends StatefulWidget {
//   final String content;
//   final String price;
//   final String planId;
//   final int daysOfPlan;
//   const PayCard({
//     super.key,
//     required this.content,
//     required this.price,
//     required this.planId,
//     required this.daysOfPlan,
//   });

//   @override
//   State<PayCard> createState() => _PayCardState();
// }

// class _PayCardState extends State<PayCard> {
//   late TextEditingController nameCtrl;
//   late TextEditingController cardCtrl;
//   late TextEditingController cvcCtrl;
//   late TextEditingController monthCtrl;
//   late TextEditingController yearCtrl;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final maskFormatter = MaskTextInputFormatter(
//       mask: '####  ####  ####  ####',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);

//   @override
//   void initState() {
//     Get.lazyPut(() => FormCtrl());
//     nameCtrl = TextEditingController();
//     cardCtrl = TextEditingController();
//     cvcCtrl = TextEditingController();
//     monthCtrl = TextEditingController();
//     yearCtrl = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     nameCtrl.dispose();
//     cardCtrl.dispose();
//     cvcCtrl.dispose();
//     monthCtrl.dispose();
//     yearCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         height: 420,
//         margin: const EdgeInsets.symmetric(horizontal: 37),
//         padding: const EdgeInsets.only(right: 0, left: 0, top: 20),
//         decoration: BoxDecoration(
//           color: MyColors.blue14B,
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Hero(
//               tag: widget.price,
//               child: Material(
//                 color: Colors.transparent,
//                 child: RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: r'$',
//                         style: GoogleFonts.tajawal(
//                           fontSize: 18,
//                           color: MyColors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       TextSpan(
//                         text: widget.price,
//                         style: GoogleFonts.tajawal(
//                           fontSize: 52,
//                           color: MyColors.white,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: CustomTextField(
//                 textInputAction: TextInputAction.next,
//                 controller: nameCtrl,
//                 onChanged: (value) {
//                   nameCtrl.value = TextEditingValue(
//                       text: value.toUpperCase(), selection: nameCtrl.selection);
//                 },
//                 hintText: 'FULL NAME',
//                 horizontalPadding: 20,
//                 textAlign: TextAlign.center,
//                 fillColor: Colors.white,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "".tr;
//                   }
//                   if (value.length < 4) {
//                     return ''.tr;
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: CustomTextField(
//                 textInputAction: TextInputAction.next,
//                 controller: cardCtrl,
//                 hintText: 'CARD NUMBER',
//                 horizontalPadding: 20,
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(22),
//                   FilteringTextInputFormatter.digitsOnly,
//                   maskFormatter
//                 ],
//                 textAlign: TextAlign.center,
//                 fillColor: Colors.white,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "".tr;
//                   }
//                   if (value.length < 22) {
//                     return ''.tr;
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: CustomTextField(
//                       textInputAction: TextInputAction.next,
//                       hintText: 'CVC',
//                       controller: cvcCtrl,
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(3),
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       horizontalPadding: 20,
//                       textAlign: TextAlign.center,
//                       fillColor: Colors.white,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return ''.tr;
//                         }
//                         if (value.length < 3) {
//                           return ''.tr;
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   Expanded(
//                     flex: 1,
//                     child: CustomTextField(
//                       textInputAction: TextInputAction.next,
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(2),
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       hintText: '00',
//                       controller: monthCtrl,
//                       horizontalPadding: 20,
//                       textAlign: TextAlign.left,
//                       fillColor: Colors.white,
//                       validator: (value) {
//                         if (value!.isEmpty ||
//                             int.parse(value) > 12 ||
//                             int.parse(value) < 1) {
//                           return "".tr;
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   Expanded(
//                     flex: 1,
//                     child: CustomTextField(
//                       textInputAction: TextInputAction.next,
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(2),
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       controller: yearCtrl,
//                       hintText: '00',
//                       horizontalPadding: 20,
//                       textAlign: TextAlign.left,
//                       fillColor: Colors.white,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "".tr;
//                         }
//                         if (int.parse(value) <
//                             int.parse(DateTime.now()
//                                 .year
//                                 .toString()
//                                 .split('0')
//                                 .last)) {
//                           return "".tr;
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             CustomElevatedButton(
//               title: MySharedPreferences.language == 'ar' ? 'دفع' : 'Pay',
//               width: double.maxFinite,
//               color: const Color(0xFF14B9D1),
//               onPressed: () {
//                 bool cardDateIsTrue = false;
//                 if (int.parse(monthCtrl.text) < 10) {
//                   DateTime cardDate = DateTime.parse(
//                       '20${yearCtrl.text}-0${monthCtrl.text}-${DateTime.now().day} 03:04:05');

//                   if (cardDate.compareTo(DateTime.now()) == 1) {
//                     cardDateIsTrue = true;
//                   } else {
//                     cardDateIsTrue = false;
//                   }
//                 } else {
//                   DateTime cardDate = DateTime.parse(
//                       '20${yearCtrl.text}-${monthCtrl.text}-${DateTime.now().day} 03:04:05');
//                   if (cardDate.compareTo(DateTime.now()) == 1) {
//                     cardDateIsTrue = true;
//                   } else {
//                     cardDateIsTrue = false;
//                   }
//                 }
//                 //TODO add payment api before create subscription
//                 if (_formKey.currentState!.validate()) {
//                   if (cardDateIsTrue) {
//                     // print(DateTime.now());
//                     PlansCtrl.find.subscribe(
//                         startDate: DateTime.now().toString().split(' ')[0],
//                         endDate: DateTime.now()
//                             .add(Duration(days: widget.daysOfPlan))
//                             .toString()
//                             .split(' ')[0],
//                         planId: widget.planId,
//                         context: context);
//                   } else {
//                     MySharedPreferences.language == 'ar'
//                         ? AppConstants().showMsgToast(context,
//                             msg: 'عذرا قد ادخلت تاريخ خاطئ')
//                         : AppConstants().showMsgToast(context,
//                             msg: 'Sorry, you entered the wrong date');
//                   }
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
