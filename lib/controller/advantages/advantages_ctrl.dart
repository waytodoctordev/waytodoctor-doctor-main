import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/pages_api.dart';
import 'package:way_to_doctor_doctor/model/pages_model.dart';

class AdvantageCtrl extends GetxController {
  static AdvantageCtrl get find => Get.find();

  PageModel? pageModel;
  late Future<PageModel?> initializePageFuture;
  Future<PageModel?> fetchPage(String id) async {
    pageModel = await PagesApi.data(pageId: id);
    return pageModel;
  }

  @override
  void onInit() {
    initializePageFuture = fetchPage('5');
    super.onInit();
  }
}
