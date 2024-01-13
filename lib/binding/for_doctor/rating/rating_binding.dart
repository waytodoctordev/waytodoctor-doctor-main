import 'package:get/get.dart';

import '../../../controller/for_doctor/ratings/get_ratings_ctrl.dart';

class RatingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetDoctorRatingsCtrl());
  }
}
