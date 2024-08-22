import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 63, right: 37, left: 37),
          children: [
            const HeaderLogo(),
            const SizedBox(height: 60),

             Text(
              'Please select the language of the application'.tr,
              style: const TextStyle(
                fontSize: 18,
                color: MyColors.blue14B,
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              title: 'Arabic'.tr,
              onPressed: () {
                MySharedPreferences.language = 'ar';
                MySharedPreferences.isPassedLanguage = true;
                Get.updateLocale(Locale(MySharedPreferences.language));
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              title: 'English'.tr,
              onPressed: () {
                MySharedPreferences.language = 'en';
                MySharedPreferences.isPassedLanguage = true;
                Get.updateLocale(Locale(MySharedPreferences.language));
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              title: 'Turkish'.tr,
              onPressed: () {
                MySharedPreferences.language = 'tr';
                MySharedPreferences.isPassedLanguage = true;
                Get.updateLocale(Locale(MySharedPreferences.language));
              },
            )
          ],
        ),
      ),
    );
  }
}
