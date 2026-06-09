import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:way_to_doctor_doctor/model/agora_model.dart';

import '../model/notifications/get_device_token_model.dart';
import '../services/send_noti_caller.dart';
import '../services/send_notifications.dart';
import '../utils/app_constants.dart';
import '../utils/shared_prefrences.dart';
import 'package:path_provider/path_provider.dart';

class ChatCtrl extends GetxController {
  static ChatCtrl get find => Get.find();
PathProviderPlatform get _platform => PathProviderPlatform.instance;

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
    // final status =
     await Permission.microphone.request();
    final tempDir = await getTemporaryDirectory(); // safe location for recording
        final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}_${MySharedPreferences.id}.mp4';
        final filePath = '${tempDir.path}/$fileName';
    
      await recorder.startRecorder(
        toFile: filePath, //'audio${DateTime.now()}${MySharedPreferences.id}.mp4',
        codec: Codec.aacMP4,
      );
      isVoiceRecorded = false;
      isVoiceRecording = true;
      recordDuration = 0;
      _startTimer();
      update();
    }
Future<Directory> getTemporaryDirectory() async {
  final String? path = await _platform.getTemporaryPath();
  if (path == null) {
    throw MissingPlatformDirectoryException(
        'Unable to get temporary directory');
  }
  return Directory(path);
}

  Future stop(context) async {
    timer?.cancel();
    recordDuration = 0;
    final path = await recorder.stopRecorder();
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
  
    getDeviceTokenOfUserModelForCall =
        await SendCallerNotification.data(userId: userId);
    if (getDeviceTokenOfUserModelForCall == null) {
      Loader.hide();
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
        doctorId: int.parse(agormaModel.doctorId),
      );
    

      update();

      return getDeviceTokenOfUserModelForCall!;
    } else if (getDeviceTokenOfUserModelForCall!.code == 500) {
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
    try{
    AppConstants.showLoading(context);
    getDeviceTokenOfUserModelForChat =
        await SendCallerNotification.data(userId: userId);
    if (getDeviceTokenOfUserModelForChat == null) {
      Loader.hide();
      return;
    }
    if (getDeviceTokenOfUserModelForChat!.code == 200) {
      deviceTokenToSend = getDeviceTokenOfUserModelForChat!.note.deviceToken;
      await SendCallNotification().chatNotification(
        status: 'CHAT',
        token: deviceTokenToSend,
        mbody: mbody,
        title: title,
        context: context,
        appointmentStatus: appointmentStatus,
        bookingType: bookingType,
        appointmentId: appointmentId,
      );
      update();
      return getDeviceTokenOfUserModelForChat!;
    }
    else if (getDeviceTokenOfUserModelForChat!.code == 500) {
      Loader.hide();
    }
  }catch(error){
    Loader.hide();
  }
}

  String localPath = '';

  /// Download and cache an audio file locally.
  /// Returns the full local file path.
  Future<String> downloadFile(String url) async {
    try {
      print('👇 Downloading voice audio: $url');

      // Get temp directory for cache
      final tempDir = await getTemporaryDirectory();

      // Create a unique filename for each file (prevents overwriting)
      final fileName = 'audio_${url.hashCode}.m4a';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);

      // ✅ If cached version exists and is valid, reuse it
      if (await file.exists() && await file.length() > 1000) {
        print("✅ Using cached audio file: ${file.path}");
        return filePath;
      }

      // 🌐 Download from network
      final response = await http.get(Uri.parse(url));

      // Check response
      if (response.statusCode != 200) {
        print("❌ Failed to download audio (HTTP ${response.statusCode})");
        return '';
      }

      // Optional: check content type (should be audio)
      final contentType = response.headers['content-type'] ?? '';
      if (!contentType.contains('audio')) {
        print("⚠️ Warning: downloaded file is not audio ($contentType)");
      }

      // Write to file
      await file.writeAsBytes(response.bodyBytes);
      final size = await file.length();

      // Validate file
      if (size < 1000) {
        print("❌ File too small — invalid audio ($size bytes)");
        await file.delete();
        return '';
      }

      print("✅ Voice audio downloaded successfully ($size bytes): $filePath");
      return filePath;
    } catch (err) {
      print("❌ Error downloading voice file: $err");
      return '';
    }
  }


}
