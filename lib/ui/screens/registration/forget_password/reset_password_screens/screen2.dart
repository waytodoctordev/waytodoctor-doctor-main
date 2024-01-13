import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/forget_password/widgets/otp_digits_reset_pass.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../widgets/prefix_icon.dart';

class ResetPassCodeVerificationScreen extends StatefulWidget {
  final String verId;
  final int skip;
  const ResetPassCodeVerificationScreen(
      {Key? key, required this.verId, required this.skip})
      : super(key: key);

  @override
  State<ResetPassCodeVerificationScreen> createState() =>
      _ResetPassCodeVerificationScreenState();
}

class _ResetPassCodeVerificationScreenState
    extends State<ResetPassCodeVerificationScreen> {
  String name = MySharedPreferences.fName;
  String email = MySharedPreferences.email;
  String phoneNum = MySharedPreferences.userNumber;
  int userId = MySharedPreferences.id;
  late TextEditingController phoneNumberCtrl;

  @override
  void dispose() {
    phoneNumberCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // OTPTimerCtrl.find.startTimer(context);
    phoneNumberCtrl = TextEditingController(text: phoneNum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 63, right: 37, left: 37),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(270 / 360),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(3),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
            ),
            const HeaderLogo(),
            const SizedBox(height: 60),
            Text(
              'Confirm phone number'.tr,
              style: const TextStyle(
                fontSize: 20,
                color: MyColors.blue14B,
              ),
            ),
            const SizedBox(height: 15),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 100),
              child: Text(
                'Please enter the verification code that was sent to the phone number:'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.blue14B,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeIn(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 450),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                controller: phoneNumberCtrl,
                readOnly: true,
                hintText: 'Phone number'.tr,
                horizontalPadding: 10,
                // keyboardType: TextInputType.phone,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.call),
              ),
            ),
            const SizedBox(height: 20),
            OTPDigitsResetPasswordWidget(
              phoneNum: phoneNum,
              name: name,
              skipOtp: widget.skip,
              verId: widget.verId,
              email: email,
              userId: userId,
            ),
          ],
        ),
      ),
    );
  }
}
