import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/loading_indicator.dart';
import '../../registration/plans/plans_screen.dart';
import '../../registration/plans/widgets/subscription_end.dart';
import '../components/doctor_center_screen.dart';


class CenterHomeScreen extends StatelessWidget {
   CenterHomeScreen({super.key});
  CenterCtrl centerCtrl = Get.put(CenterCtrl());


   @override
  Widget build(BuildContext context) {

    return GetBuilder<CenterCtrl>(
        builder: (ctrl) {
          if (MySharedPreferences.isSubscriped) {
            return const DoctorsCenterScreen();
          }
          if (!MySharedPreferences.isSubscriped) {
            return const PlansScreen();//
          } else {
            return const Scaffold(
              body: LoadingIndicator(),
            );
          }
        }
    );
  }
}
