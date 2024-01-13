import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/settings/settings_ctrl.dart';
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/friday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/monday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/saturday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/sunday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/thursday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/tuesday.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/days/wednesday.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class WorkingHoursComponents extends StatelessWidget {
  final String saturday = 'Saturday';
  final String sunday = 'Sunday';
  final String monday = 'Monday';
  final String tuesday = ' Tuesday';
  final String wednesday = 'Wednesday';
  final String thursday = 'Thursday';
  final String friday = ' Friday';

  const WorkingHoursComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsCtrl>(
      builder: (controller) => FutureBuilder<WorkHoursModel?>(
        future: SettingsCtrl.find.initializeWorkHoursForDoctor,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const LoadingIndicator();

            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'work hours'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'day'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'from'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'to'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'status'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.blue14B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Saturday(),
                    const SizedBox(height: 5),
                    const Sunday(),
                    const SizedBox(height: 5),
                    const Monday(),
                    const SizedBox(height: 5),
                    const Tuesday(),
                    const SizedBox(height: 5),
                    const Wednesday(),
                    const SizedBox(height: 5),
                    const Thursday(),
                    const SizedBox(height: 5),
                    const Friday()
                  ],
                );
              } else {
                return const FailedWidget();
              }
          }
        },
      ),
    );
  }
}
