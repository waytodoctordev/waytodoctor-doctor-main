import 'dart:async';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:way_to_doctor_doctor/model/agora_model.dart';

import '../model/notifications/get_device_token_model.dart';
import '../services/send_noti_caller.dart';
import '../services/send_notifications.dart';
import '../utils/shared_prefrences.dart';

// import 'package:record/record.dart';

class ChatCtrl extends GetxController {
  static ChatCtrl get find => Get.find();

  // StreamSubscription<RecordState>? recordSub;
  // RecordState recordState = RecordState.stop;
  // final audioRecorder = Record();

  // Future<void> start(context) async {
  //   if (await audioRecorder.hasPermission()) {
  //     await audioRecorder.start();
  //     _startTimer();
  //     // AppConstants().showMsgToast(context, msg: "Start record".tr);
  //     isVoiceRecorded = false;
  //     isVoiceRecording = true;
  //     recordDuration = 0;
  //     update();
  //   }
  // }

  // Future<void> stop(context) async {
  //   timer?.cancel();
  //   recordDuration = 0;

  //   final path = await audioRecorder.stop();
  //   if (path != null) {
  //     voiceFile = PlatformFile(name: path.split('/').last, size: 0, path: path);
  //     isVoiceRecorded = true;
  //     recordPath = path;
  //     update();
  //   }
  //   isVoiceRecording = false;
  // }

  Timer? timer;

  bool isMic = true;
  void setIsMic(bool val) {
    isMic = val;
    update();
  }

  int recordDuration = 0;
  late PlatformFile voiceFile;
  bool isVoiceRecorded = false;
  bool isVoiceRecording = false;
  String recordPath = '';
  final recorder = FlutterSoundRecorder();

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }

  @override
  void onInit() {
    initRecorder();
    super.onInit();
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      log('err');
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future start(context) async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      log('err');
    } else {
      await recorder.startRecorder(
        toFile: 'audio${DateTime.now()}${MySharedPreferences.userId}.mp4',
        codec: Codec.aacMP4,
      );
      isVoiceRecorded = false;
      isVoiceRecording = true;
      recordDuration = 0;
      _startTimer();
      update();
    }
  }

  Future stop(context) async {
    timer?.cancel();
    recordDuration = 0;
    final path = await recorder.stopRecorder();
    log(path.toString());
    if (path != null) {
      voiceFile = PlatformFile(name: path.split('/').last, size: 0, path: path);
      isVoiceRecorded = true;
      recordPath = path;
      update();
    }
    isVoiceRecording = false;
  }

  String deviceTokenToSend = '';

  GetDeviceTokenOfUserModel? getDeviceTokenOfUserModelForCall;
  Future fetchDeviceTokenForCall({
    required BuildContext context,
    required int userId,
    required AgoraModel agormaModel,
    required String channelName,
    required String callToken,
    required bool isVideo,
  }) async {
    // AppConstants.showLoading(context);
    getDeviceTokenOfUserModelForCall =
        await SendCallerNotification.data(userId: userId);
    if (getDeviceTokenOfUserModelForCall == null) {
      // Loader.hide();
      return;
    }
    if (getDeviceTokenOfUserModelForCall!.code == 200) {
      deviceTokenToSend = getDeviceTokenOfUserModelForCall!.note.deviceToken;
      await SendCallNotification().callNotification(
        status: 'CALL',
        token: getDeviceTokenOfUserModelForCall!.note.deviceToken,
        mbody: MySharedPreferences.language == 'ar' ? 'يتصل بك' : 'Calling You',
        title: agormaModel.doctorName,
        callToken: callToken,
        channelName: channelName,
        doctorName: agormaModel.doctorName,
        context: context,
        isVideo: isVideo,
        doctorId: agormaModel.doctorId,
      );
      log(agormaModel.doctorName);
      log(callToken);
      log(channelName);
      log(agormaModel.doctorId.toString());

      update();

      // return getDeviceTokenOfUserModelForCall!;
    } else if (getDeviceTokenOfUserModelForCall!.code == 500) {
      // Loader.hide();
    }
  }

  GetDeviceTokenOfUserModel? getDeviceTokenOfUserModelForChat;

  Future fetchDeviceTokenForChat(
      {required String status,
      // required String token,
      required String mbody,
      required String title,
      required int userId,
      required BuildContext context,
      required String appointmentStatus,
      required String bookingType,
      required int appointmentId}) async {
    // AppConstants.showLoading(context);
    getDeviceTokenOfUserModelForChat =
        await SendCallerNotification.data(userId: userId);
    if (getDeviceTokenOfUserModelForChat == null) {
      // Loader.hide();
      return;
    }
    if (getDeviceTokenOfUserModelForChat!.code == 200) {
      // deviceTokenToSend = getDeviceTokenOfUserModelForChat!.note.deviceToken;
      await SendCallNotification().chatNotification(
        status: 'CHAT',
        token: getDeviceTokenOfUserModelForChat!.note.deviceToken,
        mbody: mbody,
        title: title,
        context: context,
        appointmentStatus: appointmentStatus,
        bookingType: bookingType,
        appointmentId: appointmentId,
      );
      update();
      // return getDeviceTokenOfUserModelForChat!;
    } else if (getDeviceTokenOfUserModelForChat!.code == 500) {
      // Loader.hide();
    }
  }
}
