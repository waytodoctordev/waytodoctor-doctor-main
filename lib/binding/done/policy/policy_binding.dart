import 'package:get/get.dart';

import '../../../controller/done/policy/policy_ctrl.dart';

class PolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PolicyCtrl());
  }
}
