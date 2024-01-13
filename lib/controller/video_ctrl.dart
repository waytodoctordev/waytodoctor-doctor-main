// import 'dart:async';

// import 'package:get/get.dart';

// // import 'package:record/record.dart';

// class VideoCtrl extends GetxController {
//   static VideoCtrl get find => Get.find();

//   Timer? timer;
//   int start = 10;
//   bool isTimerStarted = false;
//   void setIsTimer() {
//     isTimerStarted = true;
//     update();
//     startTimer();
//   }

//   void startTimer() {
//     // if (isTimerStarted) {
//     timer = Timer.periodic(
//       const Duration(minutes: 1),
//       (Timer timer) {
//         if (start == 1) {
//           timer.cancel();
//           update();
//           Get.back();
//         } else if (start == 3) {
//           // AppConstants().showMsgToast(context,
//           //     msg: MySharedPreferences.language == 'ar'
//           //         ? 'المكالمة سوف تنتهي بعد دقيقتين'
//           //         : 'Call will end after 2 minuts');

//           // start--;
//           // update();
//         } else {
//           start--;
//           update();
//         }
//       },
//     );
//     // }
//   }

//   @override
//   void onClose() {
//     // TODO: implement onClose
//     super.onClose();
//     timer!.cancel();
//   }
// }
