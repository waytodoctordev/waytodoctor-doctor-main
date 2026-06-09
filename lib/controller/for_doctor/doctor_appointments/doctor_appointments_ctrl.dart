import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments/appointments_by_date_for_doctor_api.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';

import '../../../services/api_request_handlers/api_service.dart';

class DoctorAppointmentsCtrl extends GetxController {
  static DoctorAppointmentsCtrl get find => Get.find();

  late PagingController<int, AppointmentData> pagingController;
  String currentDate = DateTime.now().toString().split(' ')[0];
  void getCurrentDate(DateTime date) {
    currentDate = date.toString().split(' ')[0];
    update();
  }
  ApiService apiRequestService = ApiService();

  Future<void> fetchPage(int pageKey) async {
    // try {
    //   print('fetchPage');
    //   MyAppointmentsModel? response = await apiRequestService.makeRequest(
    //     method: 'GET',
    //    url: '${ApiUrl.mainUrl}${ApiUrl.appointmentsByDateForDoctor}?page=$pageKey',
    //   );
    //   print('Response: $response');
    //   // appointmentsModel = await UrgentsAppointmentsApi.data();
    //   // if (appointmentsModel!.status == true) {
    //   //   urgentsAppointments = appointmentsModel!.data!.length;
    //   // }
    //   update();
    //   return response;
    // }
    // catch(error){
    //
    // }
    try {

      final appointments = await AppointmentsByDateForDoctorApi.data(pageKey: pageKey, date: currentDate);
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
  }
}
