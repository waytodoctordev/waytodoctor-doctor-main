import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/components/appointment_card.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/ui/widgets/vertical_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class AppointmentsComponent extends StatelessWidget {
  const AppointmentsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, AppointmentData>.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      // scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.only(start: 37, end: 37),
      pagingController: DoctorHomeScreenCtrl.find.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text(
              AppConstants.noItems,
              style: const TextStyle(color: MyColors.blue14B),
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) {
          // return SizedBox(
          //   height: 160,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     physics: const NeverScrollableScrollPhysics(),
          //     separatorBuilder: (context, index) =>
          //         const SizedBox(height: 15),
          //     itemCount: 4,
          //     itemBuilder: (BuildContext context, int index) {
          //       return const BaseVerticalListLoading();
          //     },
          //   ),
          // );
          return SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              // padding: const EdgeInsetsDirectional.only(start: 37, end: 37),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              // scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
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
          return MyAppointmentCard(
            appointmentData: item,
          );
        },
      ),
    );
  }
}
