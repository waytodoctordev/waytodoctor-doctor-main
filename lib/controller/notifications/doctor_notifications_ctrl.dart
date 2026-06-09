import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/notifications/notifications_api.dart';
import 'package:way_to_doctor_doctor/model/notifications/notifications_model.dart';

class DoctorNotificationsCtrl extends GetxController {
  static DoctorNotificationsCtrl get find => Get.find();

  late PagingController<int, NotificationsData> pagingController;

  Future<void> fetchPage(int pageKey) async {
    try {
      final notifications = await DoctorNotificationsApi.data(pageKey: pageKey);
      final newItems = notifications!.data;
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
}
