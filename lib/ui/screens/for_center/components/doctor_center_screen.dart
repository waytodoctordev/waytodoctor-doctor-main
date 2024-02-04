import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/components/center_home_bar.dart';
import '../../../../controller/for_center/doctors_center_ctrl.dart';
import '../../../../utils/shared_prefrences.dart';
import 'doctor_center_component.dart';
import 'center_doctors_search_bar.dart';

class DoctorsCenterScreen extends StatefulWidget {
  const DoctorsCenterScreen({
    super.key,
  });
  @override
  State<DoctorsCenterScreen> createState() => _DoctorsCenterScreenState();
}

class _DoctorsCenterScreenState extends State<DoctorsCenterScreen> {
  CenterCtrl centerCtrl = Get.put(CenterCtrl());
  DoctorsCenterCtrl controller = Get.put(DoctorsCenterCtrl());
  @override
  void initState() {
    MySharedPreferences.lastScreen = 'DoctorsCenterScreen';

    // DoctorsCenterCtrl
    // Get.lazyPut(() => DoctorsCenterCtrl());
    DoctorsCenterCtrl.find.init(
        categoryId: int.parse(MySharedPreferences.centerCategoryID),
        search: '',
        centerId: MySharedPreferences.centerID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300), child: CenterHomeBar()),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // controller.initSlider();
            // controller.pagingController.refresh();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CenterDoctorsSearchBar(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children:  [
                    DoctorCenterComponent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
