import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../api/for_doctor/ratings/get_ratings_api.dart';
import '../../../model/get_ratings/rating_model.dart';

class GetDoctorRatingsCtrl extends GetxController {
  static GetDoctorRatingsCtrl get find => Get.find();

  late PagingController<int, RatingsDataModel> pagingController;
  String? doctorId;
  Future<void> fetchPage(int pageKey) async {
    try {
      final ratingsModel =
          await GetRatingsApi.data(doctorId: doctorId!, pageKey: pageKey);
      final newItems = ratingsModel!.data;
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
