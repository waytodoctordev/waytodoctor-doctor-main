import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class TextMessageBubble extends StatelessWidget {
  final ChatModel chatModel;
  final int doctorId;

  const TextMessageBubble({
    Key? key,
    required this.chatModel,
    required this.doctorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color:
            chatModel.userId != doctorId ? MyColors.primary : MyColors.blue9D1,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(18.0),
          bottomRight: chatModel.userId == doctorId
              ? const Radius.circular(18.0)
              : const Radius.circular(4.0),
          topLeft: chatModel.userId == MySharedPreferences.id
              ? const Radius.circular(18.0)
              : const Radius.circular(4.0),
          bottomLeft: const Radius.circular(18.0),
        ),
      ),
      child: Text(
        chatModel.message!,
        style: TextStyle(
            color: chatModel.userId != doctorId ? Colors.white : Colors.black),
      ),
    );
  }
}
