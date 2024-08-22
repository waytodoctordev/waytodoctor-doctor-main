// dependency_overrides:
// intl: ^0.17.0
// http: ^0.13.1
// #  google_api_headers: ^4.2.0
// flutter_svg: ^1.1.6
// syncfusion_flutter_core: ^22.1.37

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:way_to_doctor_doctor/binding/policy/policy_binding.dart';
// import 'package:way_to_doctor_doctor/binding/privcy/privcy_binding.dart';
// import 'package:way_to_doctor_doctor/binding/terms/terms_binding.dart';
// import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
// import 'package:way_to_doctor_doctor/ui/base/policy_screen.dart';
// import 'package:way_to_doctor_doctor/ui/base/privcy_screen.dart';
// import 'package:way_to_doctor_doctor/ui/base/terms_screen.dart';
// import 'package:way_to_doctor_doctor/ui/screens/registration/clinic_sign_in/clinic_sign_in_screen.dart';
// import 'package:way_to_doctor_doctor/ui/screens/registration/doctor_sign_in/doctor_sign_in_screen.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/base_switch_slider.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
// import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
// import 'package:way_to_doctor_doctor/utils/colors.dart';
// import 'package:way_to_doctor_doctor/utils/icons.dart';
// import 'package:way_to_doctor_doctor/utils/images.dart';
// import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
//
// import '../../../widgets/custom_elevated_button.dart';
// import '../language/language_screen.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   bool isSignIn = true;
//   int current = 0;
//   PageController pageCtrl = PageController(initialPage: 0);
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       SignInCtrl.find.getCountriesList(context: context);
//     });
//     super.initState();
//   }
//   bool check(){
//     if(MySharedPreferences.language == 'en'|| MySharedPreferences.language == 'tr'){
//       return isSignIn;
//     }
//     else{
//       return !isSignIn;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             height: size.height,
//             width: size.width,
//             child: Image.asset(
//               MyImages.loginImage,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: GetBuilder<SignInCtrl>(
//               // init: SignInCtrl(),
//               builder: (controller) => ListView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.only(top: 40, right: 37, left: 37),
//                 children: [
//                   const HeaderLogo(),
//                   const SizedBox(height: 5),
//                   BaseSwitchSlider(
//                     margin: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
//                     textColor1: isSignIn ? MyColors.white : MyColors.blue14B,
//                     textColor2: isSignIn ? MyColors.blue14B : MyColors.white,
//                     color: Colors.transparent,
//                     title1:  'Doctor'.tr,
//                     title2: 'Clinic'.tr,
//                     onTap1: () {
//                       setState(
//                             () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           isSignIn = true;
//                           pageCtrl.animateToPage(0,
//                             duration: const Duration(milliseconds: 750),
//                             curve: Curves.fastOutSlowIn,
//                           );
//                         },
//                       );
//                     },
//                     onTap2: () {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                       setState(
//                             () {
//                           isSignIn = false;
//                           pageCtrl.animateToPage(1,
//                             duration: const Duration(milliseconds: 750),
//                             curve: Curves.fastOutSlowIn,
//                           );
//                         },
//                       );
//                     },
//                     isFirst: check(),// MySharedPreferences.language == 'en'
//                     //     ?    isSignIn
//                     //     :   !isSignIn,
//                     buttonColor: MyColors.blue14B,
//                   ),
//                   const SizedBox(height: 5),
//                   CustomTextField(
//                     textInputAction: TextInputAction.next,
//                     hintText: controller.currentCountry,
//                     autoValidateMode: AutovalidateMode.always,
//                     readOnly: true,
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         backgroundColor: Colors.transparent,
//                         builder: (BuildContext context) {
//                           return CupertinoActionSheet(
//                             cancelButton: CupertinoActionSheetAction(
//                               onPressed: () => Get.back(),
//                               // isDefaultAction: true,
//                               child: Text(
//                                 'Cancel'.tr,
//                                 style: GoogleFonts.tajawal(
//                                   fontSize: 16,
//                                   color: MyColors.red,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             actions: [
//                               SizedBox(
//                                 height: 250,
//                                 child: CupertinoPicker(
//                                   onSelectedItemChanged: (value) {
//                                     controller.getCurrentCountry(
//                                       controller.countries![value].name
//                                           .toString(),
//                                     );
//                                     controller.getCurrentCountryCode(
//                                       controller.countries![value].code
//                                           .toString(),
//                                     );
//                                     controller.getCurrentCountryImage(
//                                       controller.countries![value].image
//                                           .toString(),
//                                     );
//                                     controller.getCurrentDigits(
//                                         controller.countries![value].digits!);
//                                   },
//                                   itemExtent: 28.0,
//                                   children: controller.countries!.map(
//                                         (item) {
//                                       return Center(
//                                         child: Text(
//                                           item.name.toString().tr,
//                                           style: GoogleFonts.tajawal(
//                                             fontSize: 16,
//                                             color: MyColors.blue14B,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     suffixIcon: SvgPicture.asset(
//                       MyIcons.angleSmallRight,
//                       height: 7,
//                       width: 14,
//                     ),
//                     prefixIcon: Container(
//                       width: 80,
//                       height: 60,
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CustomNetworkImage(
//                             url: controller.currentCountryImage,
//                             radius: 10,
//                             height: 27,
//                             width: 27,
//                           ),
//                           const VerticalDivider(
//                             color: MyColors.blue14B,
//                             thickness: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   SizedBox(
//                     height: size.height * .40,
//                     child: PageView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       controller: pageCtrl,
//                       scrollDirection: Axis.horizontal,
//                       onPageChanged: (index) {
//                         if (index > 0) {
//                           setState(() {
//                             isSignIn = false;
//                           });
//                         } else {
//                           setState(() {
//                             isSignIn = true;
//                           });
//                         }
//                         setState(() {
//                           current = index;
//                         });
//                       },
//                       children: const [
//                         DoctorSignInScreen(),
//                         ClinicSignInScreen(),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'This application is for health service providers, doctors, physiotherapists, home nursing, and nutritionists'
//                         .tr,
//                     style: const TextStyle(
//                         color: MyColors.blue14B,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () => Get.to(() => const PrivcyScreen(),
//                                 binding: PrivacyBinding()),
//                             child: Text(
//                               'Privacy policy'.tr,
//                               style: const TextStyle(
//                                 color: MyColors.blue14B,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => Get.to(() => const TermsScreen(),
//                                 binding: Termsinding()),
//                             child: Text(
//                               'Terms and Conditions'.tr,
//                               style: const TextStyle(
//                                 color: MyColors.blue14B,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => Get.to(() => const PolicyScreen(),
//                                 binding: PolicyBinding()),
//                             child: Text(
//                               'Return policy'.tr,
//                               style: const TextStyle(
//                                 color: MyColors.blue14B,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       const Spacer(),
//                       Image.asset(
//                         MyImages.visa,
//                         // height: 20,
//                         width: 60,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
