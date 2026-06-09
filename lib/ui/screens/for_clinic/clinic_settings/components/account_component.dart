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
        return const SizedBox();// ClinicPasswordComponent();
      },
    );
  }
}
