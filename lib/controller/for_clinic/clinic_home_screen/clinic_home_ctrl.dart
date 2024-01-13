import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointments/appointments_by_clinic_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/home_screen/clinic_counter_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/home_screen/clinic_urgents_api.dart';
import 'package:way_to_doctor_doctor/model/home_screen/appointment_counter_model.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';

class ClinicHomeScreenCtrl extends GetxController {
  static ClinicHomeScreenCtrl get find => Get.find();

  late PagingController<int, AppointmentData> pagingController;

  Future<void> fetchPage(int pageKey) async {
    try {
      final appointments = await AppointmentsByClinicApi.data(pageKey: pageKey);
      final newItems = appointments!.data;
      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUrgentAppointments();
    fetchAppointmentsCounter();
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey);
      });
  }

  MyAppointmentsModel? urgents;
  int urgentsAppointments = 0;
  Future<MyAppointmentsModel?> fetchUrgentAppointments() async {
    urgents = await ClinicUrgentsApi.data();
    urgentsAppointments = urgents!.data!.length;
    update();
    return urgents;
  }

  int finishedAppointments = 0;
  int bindingAppointments = 0;
  AppointmentCounterModel? appointmentCounterModel;

  Future<AppointmentCounterModel?> fetchAppointmentsCounter() async {
    appointmentCounterModel = await ClinicCounterApi.data();
    finishedAppointments = appointmentCounterModel!.data!.completed!;
    bindingAppointments = appointmentCounterModel!.data!.notCompleted!;

    update();
    return appointmentCounterModel;
  }
}
