import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/settings/clinic_settings_ctrl.dart';

class ClinicAccountComponent extends StatefulWidget {
  const ClinicAccountComponent({super.key});

  @override
  State<ClinicAccountComponent> createState() => _ClinicAccountComponentState();
}

class _ClinicAccountComponentState extends State<ClinicAccountComponent> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicSettingsCtrl>(
      builder: (controller) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, right: 37, left: 37, bottom: 0),
          children: const [
            // OutlinedButton(
            //   onPressed: () {
            //     MySharedPreferences.clearProfile();
            //     Get.deleteAll(force: true);
            //     Get.offAll(
            //       () => const RegistrationScreen(),
            //       binding: RegestirationBinding(),
            //     );
            //   },
            //   style: ButtonStyle(
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(24.0),
            //         side: const BorderSide(width: 10, color: MyColors.red),
            //       ),
            //     ),
            //     backgroundColor: MaterialStateProperty.all(Colors.white),
            //   ),
            //   child: Text(
            //     'Sign out'.tr,
            //     style: const TextStyle(
            //       fontSize: 14,
            //       color: MyColors.red101,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
