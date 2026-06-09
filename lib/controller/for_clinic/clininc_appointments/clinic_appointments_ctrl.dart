import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointments/appointments_by_clinic_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointments/clinic_canceled_appointments_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointments/clinic_finished_appointments_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointments/clinic_next_appointments_api.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';

class ClinicAppointmentsCtrl extends GetxController {
  static ClinicAppointmentsCtrl get find => Get.find();

  List<String> appointmentsType = [
    'All'.tr,
    'Coming'.tr,
    'Finished'.tr,
    'Canceled'.tr,
  ];

  int currentAppointmentTypeIndex = 0;

  void getCurrentAppointmentTypeIndex(int index) {
    currentAppointmentTypeIndex = index;
    update();
  }

  late PagingController<int, AppointmentData> pagingController;
  Future<void> fetchPage(int pageKey) async {
    if (currentAppointmentTypeIndex == 0) {
      try {
        // print(currentAppointmentTypeIndex);

        final appointments = await AppointmentsByClinicApi.data(pageKey: pageKey);
        final newItems = appointments!.data;
        // print(newItems!.length);

        if (newItems!.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        update();
      } catch (error) {
        pagingController.error = error;
      }
    }
    if (currentAppointmentTypeIndex == 1) {
      try {
        // print(currentAppointmentTypeIndex);

        final nextAppointments = await MyNextAppointmentsApi.data(pageKey: pageKey);
        final newItems = nextAppointments!.data;
        // print(newItems!.length);

        if (newItems!.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        update();
      } catch (error) {
        pagingController.error = error;
      }
    }
    if (currentAppointmentTypeIndex == 2) {
      try {
        // print(currentAppointmentTypeIndex);

        final finishedAppointments = await ClinicFinishedAppointmentsApi.data(pageKey: pageKey);
        final newItems = finishedAppointments!.data;
        // print(newItems!.length);

        if (newItems!.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        update();
      } catch (error) {
        pagingController.error = error;
      }
    }
    if (currentAppointmentTypeIndex == 3) {
      try {
        // print(currentAppointmentTypeIndex);

        final canceledAppointments = await ClinicCanceledAppointmentsApi.data(pageKey: pageKey);
        final newItems = canceledAppointments!.data;
        // print(newItems!.length);

        if (newItems!.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        update();
      } catch (error) {
        pagingController.error = error;
      }
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey);
      });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
