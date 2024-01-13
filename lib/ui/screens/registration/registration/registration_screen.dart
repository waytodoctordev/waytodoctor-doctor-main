import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/binding/policy/policy_binding.dart';
import 'package:way_to_doctor_doctor/binding/privcy/privcy_binding.dart';
import 'package:way_to_doctor_doctor/binding/terms/terms_binding.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/policy_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/privcy_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/terms_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/clinic_sign_in/clinic_sign_in_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/doctor_sign_in/doctor_sign_in_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import '../../../widgets/users_sliders.dart';
import '../../for_center/screens/center_registeration/center_sign_in_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  SignInCtrl signInCtrl = Get.put(SignInCtrl());
  PageController pageCtrl = PageController(initialPage: 0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SignInCtrl.find.getCountriesList(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              MyImages.loginImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: GetBuilder<SignInCtrl>(
              // init: SignInCtrl(),
              builder: (controller) => ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 40, right: 37, left: 37),
                children: [
                  const HeaderLogo(),
                  const SizedBox(height: 5),
                  UsersSliders(
                    pageCtrl: pageCtrl,
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    hintText: controller.currentCountry.tr,
                    autoValidateMode: AutovalidateMode.always,
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Get.back(),
                              // isDefaultAction: true,
                              child: Text(
                                'Cancel'.tr,
                                style: GoogleFonts.tajawal(
                                  fontSize: 16,
                                  color: MyColors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            actions: [
                              SizedBox(
                                height: 250,
                                child: CupertinoPicker(
                                  onSelectedItemChanged: (value) {
                                    controller.getCurrentCountry(
                                      controller.countries![value].name
                                          .toString(),
                                    );
                                    controller.getCurrentCountryCode(
                                      controller.countries![value].code
                                          .toString(),
                                    );
                                    controller.getCurrentCountryImage(
                                      controller.countries![value].image
                                          .toString(),
                                    );
                                    controller.getCurrentDigits(
                                        controller.countries![value].digits!);
                                  },
                                  itemExtent: 28.0,
                                  children: controller.countries!.map(
                                    (item) {
                                      return Center(
                                        child: Text(
                                          item.name.toString().tr,
                                          style: GoogleFonts.tajawal(
                                            fontSize: 16,
                                            color: MyColors.blue14B,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    suffixIcon: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      height: 7,
                      width: 14,
                    ),
                    prefixIcon: Container(
                      width: 80,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomNetworkImage(
                            url: controller.currentCountryImage,
                            radius: 10,
                            height: 27,
                            width: 27,
                          ),
                          const VerticalDivider(
                            color: MyColors.blue14B,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: Get.height * .4,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageCtrl,
                      scrollDirection: Axis.horizontal,
                      children: const [
                        DoctorSignInScreen(),
                        ClinicSignInScreen(),
                        CenterSignInScreen(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'This application is for health service providers, doctors, physiotherapists, home nursing, and nutritionists'
                        .tr,
                    style: const TextStyle(
                        color: MyColors.blue14B,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.to(() => const PrivcyScreen(),
                                binding: PrivacyBinding()),
                            child: Text(
                              'Privacy policy'.tr,
                              style: const TextStyle(
                                color: MyColors.blue14B,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const TermsScreen(),
                                binding: Termsinding()),
                            child: Text(
                              'Terms and Conditions'.tr,
                              style: const TextStyle(
                                color: MyColors.blue14B,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const PolicyScreen(),
                                binding: PolicyBinding()),
                            child: Text(
                              'Return policy'.tr,
                              style: const TextStyle(
                                color: MyColors.blue14B,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        MyImages.visa,
                        // height: 20,
                        width: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
