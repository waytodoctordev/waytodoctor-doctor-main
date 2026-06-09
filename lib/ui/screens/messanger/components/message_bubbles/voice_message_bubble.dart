import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/chat_ctrl.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../../../widgets/custom_shimmer_loading.dart';

class VoiceMessageBubble extends StatefulWidget {
  final bool isME;
  final String fileUrl;
  final String doctorImageProfile;

  const VoiceMessageBubble(
      {super.key,
      required this.isME,
      required this.fileUrl,
      required this.doctorImageProfile});

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  late final PlayerController _playerController;
  ChatCtrl controller = Get.find<ChatCtrl>();
  String localPath = '';
  bool _isPlaying = false;
  @override
  void initState() {
    _playerController = PlayerController();
    getfile();
    super.initState();
  }

  getfile() async {
    localPath = await controller.downloadFile(widget.fileUrl);

    if (localPath.isEmpty) return;

    await _playerController.preparePlayer(
      path: localPath,
      shouldExtractWaveform: true,
      noOfSamples: 80,
    );
    await Future.delayed(const Duration(milliseconds: 100));

    await _playerController.seekTo(10);
    // 👇 Listen for player state changes
    _playerController.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.stopped || state == PlayerState.paused) {
        setState(() {
          _isPlaying = false; // reset the icon to play
        });
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (localPath.isEmpty) {
      return SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.only(start: 37, end: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return CustomShimmerLoading(
              radius: 24,
              height: 130,
              width: MediaQuery.of(context).size.width * 0.5,
            );
          },
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: Get.height * .08,
      decoration: BoxDecoration(
        color: !widget.isME ? MyColors.grey5d8 : MyColors.primary,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(18.0),
          topLeft: const Radius.circular(20.0),
          bottomRight: widget.isME
              ? const Radius.circular(20.0)
              : const Radius.circular(1.0),
          bottomLeft: const Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: MyColors.blue14B.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: MySharedPreferences.userImage.isNotEmpty
                  ? CustomNetworkImage(
                      url: widget.isME
                          ? widget.doctorImageProfile
                          : MySharedPreferences.userImage,
                      radius: 40,
                      boxFit: BoxFit.cover,
                    )
                  : Image.asset(
                      MyImages.blankProfile,
                    ),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                if (!_playerController.playerState.isPlaying &&
                    !_playerController.playerState.isPaused) {
                  await _playerController.preparePlayer(
                    path: localPath,
                    shouldExtractWaveform: true,
                  );
                }

                if (_playerController.playerState == PlayerState.playing) {
                  await _playerController.pausePlayer();
                  setState(() {
                    _isPlaying = false;
                  });
                } else {
                  await _playerController.startPlayer(
                    forceRefresh: true,
                  );
                  setState(() {
                    _isPlaying = true;
                  });
                  _isPlaying = true;
                }

                setState(() {
                  // _isPlaying = !_isPlaying;
                }); // refresh icon
              } catch (e) {
                debugPrint("❌ Error controlling audio: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to play audio. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: Icon(
                _isPlaying ? Icons.pause_circle_filled : Icons.play_arrow,
                key: ValueKey(
                  _isPlaying ? 'pause' : 'play',
                ),
                // color: const Color.fromARGB(255, 28, 21, 21),
                size: 34,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  // color: Colors.black12.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AudioFileWaveforms(
                  size: const Size(double.infinity, 10),
                  playerController: _playerController,
                  enableSeekGesture: false,
                  waveformType:
                      _isPlaying ? WaveformType.long : WaveformType.fitWidth,
                  playerWaveStyle: const PlayerWaveStyle(
                      fixedWaveColor: Colors.black26,
                      liveWaveColor: Colors.black87,
                      waveThickness: 3, // thickness of each wave line
                      showSeekLine: false,
                      showTop: true,
                      showBottom: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


   


// import 'package:flutter/material.dart';
// import 'package:voice_message_package/voice_message_package.dart';
// import 'package:way_to_doctor_doctor/model/chat_model.dart';
// import 'package:way_to_doctor_doctor/utils/images.dart';

// import '../../../../../utils/colors.dart';
// import '../../../../../utils/shared_prefrences.dart';

// class VoiceMessageBubble extends StatelessWidget {
//   final ChatModel chatModel;
//   final int doctorId;

//   const VoiceMessageBubble({
//     super.key,
//     required this.chatModel,
//     required this.doctorId,
//   });

//   Widget getPlaceHolder() {
//     return Image.asset(
//       MyImages.wayToDoctorLogo,
//       fit: BoxFit.cover,
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return chatModel.fileUrl == null
//         ? const SizedBox(
//             height: 20,
//             width: 20,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ),
//           )
//         : VoiceMessageView(
//       controller: VoiceController(
//         audioSrc:
//         chatModel.fileUrl!,
//         onComplete: () {

//           /// do something on complete
//         },
//         onPause: () {
//           /// do something on pause
//         },
//         onPlaying: () {
//           /// do something on playing
//         },
//         onError: (err) {
//           /// do somethin on error
//         }, maxDuration: const Duration(seconds: 10), isFile: false,
//       ),

//       innerPadding: 12,
//       cornerRadius: 20,
//           backgroundColor:
//                 chatModel.userId == MySharedPreferences.id.toString()
//                     ? MyColors.blue14B
//                     : MyColors.blue9D1, 
//     );//const SizedBox.shrink();
//     //TODO: Deprecated -- Nancy
//     // VoiceMessage(
//     //         audioSrc: chatModel.fileUrl!,
//     //         played: false, // To show played badge or not.
//     //         me: chatModel.userId == MySharedPreferences.id
//     //             ? true
//     //             : false, // Set message side.
//     //         contactBgColor: MyColors.blue9D1,
//     //         contactFgColor: MyColors.blue14B,
//     //         contactPlayIconColor: MyColors.white,
//     //
//     //         meBgColor: MyColors.blue14B,
//     //         meFgColor: MyColors.white,
//     //         mePlayIconColor: MyColors.blue14B,
//     //       );
//   }
// }
