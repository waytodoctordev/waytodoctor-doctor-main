import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/model/center/center_model.dart';
import 'package:way_to_doctor_doctor/model/home_screen/appointment_counter_model.dart';
import 'package:way_to_doctor_doctor/model/home_screen/slider_model.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/services/api_request_handlers/api_service.dart';
import '../../../model/available_doctors_model.dart';
import '../../../model/doctor_model/doctor_model.dart';
import '../../../utils/api_url.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefrences.dart';

class DoctorHomeScreenCtrl extends GetxController {
  static DoctorHomeScreenCtrl get find => Get.find();
  ApiService apiRequestService = ApiService();

  RxInt finishedAppointments = 0.obs;
  RxInt bindingAppointments = 0.obs;
  bool isLoading = true;
  RxInt urgentAppointments = 0.obs;

  SlidersModel? slidersModel;
  List<SlidersData>? data;
  MyAppointmentsModel? appointmentsModel;
  AppointmentCounterModel? appointmentCounterModel;
  AvailableDoctorsModel? availableDoctorsResponse;
  List<Doctors>? availableDoctors;
  DoctorDetails? doctorDetails ;
  DoctorDetailsModel? doctorDetailsResponse ;
  late PagingController<int, AppointmentData> pagingController;

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchSliderData();
    fetchUrgentAppointments();
    fetchAppointmentsCounter();
    fetchAvailableDoctors();
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey);
      });
  }

  /// DONE . // ads container API
  Future<void> fetchSliderData() async {
    print('fetchSliderData');
    slidersModel = await apiRequestService.makeRequest(
      method: AppConstants.getMethod,
      url: '${ApiUrl.mainUrl}${ApiUrl.sliders}',
      fromJson: (json) =>
          SlidersModel.fromJson(json), // Pass the parsing function
    );
    data = slidersModel!.data;
        print('data ${data![0].image}');

    isLoading = false;
    update();
    return;
  }

  /// DONE . // Urgent Appointments container API
  Future<void> fetchUrgentAppointments() async {
    appointmentsModel = await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url:
            '${ApiUrl.mainUrl}${ApiUrl.urgentsAppointmentsForDoctor}/${MySharedPreferences.id}',
        fromJson: (json) => MyAppointmentsModel.fromJson(json));
    urgentAppointments.value = appointmentsModel!.data!.length;
    update();
    return;
  }

  /// DONE . // Finished &Coming Appointments Counter container API
  Future<void> fetchAppointmentsCounter() async {
    appointmentCounterModel = await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url:
            '${ApiUrl.mainUrl}${ApiUrl.counterForDoctor}/${MySharedPreferences.id}',
        fromJson: (json) => AppointmentCounterModel.fromJson(json));
    finishedAppointments.value = appointmentCounterModel!.data!.completed!;
    bindingAppointments.value = appointmentCounterModel!.data!.notCompleted!;
    update();
    return;
  }

  /// DONE . // Appointments Details container API
  Future<void> fetchPage(int pageKey) async {
    try {
      MyAppointmentsModel appointments = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url:
              '${ApiUrl.mainUrl}${ApiUrl.appointmentsByDoctor}/${MySharedPreferences.id}?page=$pageKey',
          fromJson: (json) => MyAppointmentsModel.fromJson(json));
      final newItems = appointments.data;
      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshHome() async {
    await Future.wait([
      fetchUrgentAppointments(),
      fetchAppointmentsCounter(),
      fetchAvailableDoctors(),
      fetchSliderData(),
    ]);

   pagingController.refresh();
  }
  /// DONE . // fetch Available Doctors API
  Future<void> fetchAvailableDoctors() async {
    availableDoctorsResponse = await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url:
        '${ApiUrl.mainUrl}${ApiUrl.avaliableDoctors}',
        fromJson: (json) => AvailableDoctorsModel.fromJson(json));

    availableDoctors = availableDoctorsResponse!.data;
    update();
    return;
  }
  Future<DoctorDetails?> fetchDoctorDetailsData(String doctorId) async {
    try {

          doctorDetailsResponse = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.getDoctorDetails}/$doctorId',
          fromJson: (json) => DoctorDetailsModel.fromJson(json),
        );
        if (doctorDetailsResponse!.code == 200) {
          doctorDetails = doctorDetailsResponse!.data;
          update();

        } else if (doctorDetailsResponse!.code == 500) {
          print('doctorDetailsResponse!.code ${doctorDetailsResponse!.code}');
          throw "Doctor Error";

        } else {
          throw "Doctor Error";
        }

      return doctorDetails;
    } catch (error) {
      print("Doctor details Error $error");
      return null;
    }
  }

}
