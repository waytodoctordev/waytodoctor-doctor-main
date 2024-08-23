import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class VoiceMessageBubble extends StatelessWidget {
  final ChatModel chatModel;
  final int doctorId;

  const VoiceMessageBubble({
    Key? key,
    required this.chatModel,
    required this.doctorId,
  }) : super(key: key);

  Widget getPlaceHolder() {
    return Image.asset(
      MyImages.wayToDoctorLogo,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return chatModel.fileUrl == null
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : const SizedBox.shrink();
    //TODO: Deprecated -- Nancy
    // VoiceMessage(
    //         audioSrc: chatModel.fileUrl!,
    //         played: false, // To show played badge or not.
    //         me: chatModel.userId == MySharedPreferences.id
    //             ? true
    //             : false, // Set message side.
    //         contactBgColor: MyColors.blue9D1,
    //         contactFgColor: MyColors.blue14B,
    //         contactPlayIconColor: MyColors.white,
    //
    //         meBgColor: MyColors.blue14B,
    //         meFgColor: MyColors.white,
    //         mePlayIconColor: MyColors.blue14B,
    //       );
  }
}
