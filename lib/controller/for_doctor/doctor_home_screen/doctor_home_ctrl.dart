import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments/appointments_by_doctor_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/home_screen/appointments_counter_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/home_screen/sliders_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/home_screen/urgents_appointments_api.dart';

import 'package:way_to_doctor_doctor/model/home_screen/appointment_counter_model.dart';
import 'package:way_to_doctor_doctor/model/home_screen/slider_model.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';

class DoctorHomeScreenCtrl extends GetxController {
  static DoctorHomeScreenCtrl get find => Get.find();

  SlidersModel? slidersModel;
  late Future<SlidersModel?> initializeSliderFuture;

  Future<SlidersModel?> fetchSliderData() async {
    slidersModel = await SlidersApi.data();
    // update();
    return slidersModel;
  }

  initSlider() {
    initializeSliderFuture = fetchSliderData();
    update();
  }

  late PagingController<int, AppointmentData> pagingController;

  Future<void> fetchPage(int pageKey) async {
    try {
      final appointments = await AppointmentsByDoctorApi.data(pageKey: pageKey);
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

    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey);
      });

    fetchUrgentAppointments();
    fetchAppointmentsCounter();
    initSlider();
  }

  MyAppointmentsModel? appointmentsModel;
  int urgentsAppointments = 0;
  Future<MyAppointmentsModel?> fetchUrgentAppointments() async {
    appointmentsModel = await UrgentsAppointmentsApi.data();
    if (appointmentsModel!.status == true) {
      urgentsAppointments = appointmentsModel!.data!.length;
    }
    update();
    return appointmentsModel;
  }

  int finishedAppointments = 0;
  int bindingAppointments = 0;
  AppointmentCounterModel? appointmentCounterModel;

  Future<AppointmentCounterModel?> fetchAppointmentsCounter() async {
    appointmentCounterModel = await AppointmentsCounterApi.data();
    finishedAppointments = appointmentCounterModel!.data!.completed!;
    bindingAppointments = appointmentCounterModel!.data!.notCompleted!;
    update();
    return appointmentCounterModel;
  }
}
