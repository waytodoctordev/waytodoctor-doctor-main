import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments/doctor_appointments_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/components/appointment_card.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/ui/widgets/vertical_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorAppointmentsCtrl>(
      builder: (controller) => Scaffold(
          // appBar:
          body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 100,
        displacement: 60,
        onRefresh: () async {
          controller.pagingController.refresh();
          DoctorHomeScreenCtrl.find.fetchUrgentAppointments();
          DoctorHomeScreenCtrl.find.fetchAppointmentsCounter();
          DoctorHomeScreenCtrl.find.pagingController.refresh();
        },
        child: Column(
          children: [
            CalendarAgenda(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              onDateSelected: (date) {
                if (controller.currentDate != date.toString().split(' ')[0]) {
                  controller.getCurrentDate(date);
                  controller.pagingController.refresh();
                }
              },
              locale: MySharedPreferences.language,
              backgroundColor: MyColors.blue14B,
              appbar: true,
              selectedDayPosition: SelectedDayPosition.center,
              fullCalendar: true,
              leading: IconButton(
                onPressed: () =>
                    DoctorBaseNavBarCtrl.find.navBarController.jumpToTab(0),
                icon: MySharedPreferences.language == 'ar'
                    ? RotationTransition(
                        turns: const AlwaysStoppedAnimation(270 / 360),
                        child: SvgPicture.asset(
                          MyIcons.angleSmallRight,
                          height: 7,
                          width: 7,
                          color: MyColors.white,
                        ),
                      )
                    : RotationTransition(
                        turns: const AlwaysStoppedAnimation(90 / 360),
                        child: SvgPicture.asset(
                          MyIcons.angleSmallRight,
                          height: 7,
                          width: 7,
                          color: MyColors.white,
                        ),
                      ),
              ),
              calendarEventColor: MyColors.blue14B,

              fullCalendarDay: WeekDay.long,
              fullCalendarScroll: FullCalendarScroll.horizontal,
              selectedDateColor: MyColors.blue14B,
              // selectedDayPosition: SelectedDayPosition.center,
            ),
            // const AppointmentsScreenAppbar(),
            // const SizedBox(height: 20),
            Expanded(
              child: PagedListView<int, AppointmentData>.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(bottom: 20, right: 37, left: 37),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  noItemsFoundIndicatorBuilder: (context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset(MyImages.noItems, repeat: true),
                          ),
                          Text(
                            AppConstants.noItems,
                            style: const TextStyle(color: MyColors.blue14B),
                          )
                        ],
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return const BaseVerticalListLoading();
                        },
                      ),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const LoadingIndicator();
                  },
                  itemBuilder: (context, item, index) {
                    return MyAppointmentCard(appointmentData: item);
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
