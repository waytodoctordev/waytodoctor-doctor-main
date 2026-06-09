import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/loading_indicator.dart';
import '../../registration/plans/plans_screen.dart';
import '../../subscription_details/subscription_screen.dart';
import '../components/doctor_centers_component.dart';

class CenterHomeScreen extends StatefulWidget {
   const CenterHomeScreen({super.key});

  @override
  State<CenterHomeScreen> createState() => _CenterHomeScreenState();
}

class _CenterHomeScreenState extends State<CenterHomeScreen> {
  final CenterCtrl centerCtrl = Get.put(CenterCtrl());

   @override
   void initState() {
     MySharedPreferences.lastScreen = 'CenterHomeScreen';
     super.initState();
   }

   @override
  Widget build(BuildContext context) {
    return GetBuilder<CenterCtrl>(
        builder: (ctrl) {
          if (MySharedPreferences.isSubscriped) {
            return const DoctorsCenterScreen();
          }
          if (!MySharedPreferences.isSubscriped) {
            return Platform.isIOS ? const SubscriptionScreen():const PlansScreen();
          } else {
            return const Scaffold(
              body: LoadingIndicator(),
            );
          }
        }
    );
  }
}
