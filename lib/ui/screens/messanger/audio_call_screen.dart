import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_rounded_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../widgets/custom_elevated_button.dart';

// 106242928
// 5555

class AudioCallScreen extends StatefulWidget {
  final String token;
  final String channelName;
  final String patientName;
  final int patientId;

  const AudioCallScreen({
    Key? key,
    required this.token,
    required this.channelName,
    required this.patientName,
    required this.patientId,
  }) : super(key: key);

  @override
  State<AudioCallScreen> createState() => AudiooCallScreenState();
}

class AudiooCallScreenState extends State<AudioCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  bool isMuted = false;
  bool isCameraEnabled = false;

  Timer? timer;
  int _start = 10;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            timer.cancel();
            Get.back();
          });
        } else {
          if (_start == 3) {
            AppConstants().showMsgToast(context,
                msg: MySharedPreferences.language == 'ar'
                    ? 'المكالمة سوف تنتهي بعد دقيقتين'
                    : 'Call will end after 2 minuts');
          }
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
    _engine.muteLocalAudioStream(isMuted);
  }

  Future<void> initAgora() async {
    try {
      log('initAgora');
      // retrieve permissions
      await [Permission.microphone, Permission.camera].request();

      //create the engine
      _engine = createAgoraRtcEngine();
      await _engine.initialize(
        const RtcEngineContext(
          appId: AppConstants.agoraAppId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            log("local user ${connection.localUid} joined*********************************************");
            if (mounted) {
              setState(() {
                _localUserJoined = true;
              });
            } else {}
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            log("remote user $remoteUid joined*********************************************");
            if (mounted) {
              setState(() {
                _remoteUid = remoteUid;
              });
            }
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            log("remote user $remoteUid left channel");
            if (mounted) {
              setState(() {
                _remoteUid = null;
              });
            }
            Get.back();
          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
          onError: (err, msg) {
            log(msg);
            log(err.name);
          },
        ),
      );

      // VideoEncoderConfiguration videoEncoderConfiguration = const VideoEncoderConfiguration(dimensions: VideoDimensions(height: 1920, width: 1080));
      // await _engine.setVideoEncoderConfiguration(videoEncoderConfiguration);
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await _engine.enableVideo();
      // await _engine.enableLocalVideo(widget.isVideo);
      await _engine.startPreview();
      await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
    } catch (error) {
      log("Error:: $error");
    }
  }

  @override
  void initState() {
    initAgora();
    // isCameraEnabled = widget.isVideo;
    startTimer();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    timer!.cancel();
    FirebaseFirestore.instance
        .collection('chat')
        .doc('${widget.patientId}${MySharedPreferences.id}')
        .update({
      // 'isActive': false,
      'canCall': false,
      'token': '',
    });
    try {
      FirebaseFirestore.instance
          .collection('calls')
          .doc('${widget.patientId}${MySharedPreferences.id}')
          .update({
        // 'isActive': false,
        'callStatus': AppConstants.finished,
      });
    } catch (e) {
      log(e.toString());
    }
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: MyColors.secondary,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.patientName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.8),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF323137).withOpacity(0.20),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: MyColors.primary,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.timer,
                                size: 30.0, color: Colors.white),
                            const SizedBox(width: 5.0),
                            Text(
                              '$_start',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Spacer(),
                          // CustomRoundedButton(
                          //   icon: isCameraEnabled
                          //       ? Icons.videocam
                          //       : Icons.videocam_off,
                          //   backgroundColor: Colors.transparent,
                          //   onPressed: () {
                          //     // showCamera();
                          //   },
                          // ),
                          CustomRoundedButton(
                            backgroundColor: MyColors.red101,
                            diameter: 65.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            icon: Icons.phone,
                            onPressed: () {
                              _onWillPop();
                            },
                          ),
                          CustomRoundedButton(
                            icon: isMuted ? Icons.mic_off : Icons.mic,
                            onPressed: () {
                              toggleMute();
                            },
                          ),
                          const Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    MySharedPreferences.language == 'ar'
                        ? 'هل أنت متأكد من إنهاء المكالمة'
                        : "Are you sure",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              title: 'No'.tr,
                              textColor: MyColors.blue14B,
                              onPressed: () {
                                Get.back();
                              },
                              color: MyColors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomElevatedButton(
                              title: 'Yes'.tr,
                              textColor: MyColors.white,
                              onPressed: () async {
                                Get.back();
                                Get.back();
                              },
                              color: MyColors.red101,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    return shouldPop!;
  }
}
