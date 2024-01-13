import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/pdf_view_screen.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PdfMessageBubble extends StatelessWidget {
  final ChatModel chatModel;
  final int doctorId;

  const PdfMessageBubble({
    Key? key,
    required this.chatModel,
    required this.doctorId,
  }) : super(key: key);

  Future<void> _openPdf(BuildContext context, String url) async {
    try {
      var uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch';
      }
    } catch (e) {
      log('PdfError:: $e');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: chatModel.fileUrl == null
          ? null
          : () {
              Get.to(() => PdfViewScreen(pdfUrl: chatModel.fileUrl!));
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.only(
                topRight: chatModel.userId == doctorId ? const Radius.circular(12.0) : Radius.zero,
                bottomRight: const Radius.circular(12.0),
                topLeft: chatModel.userId == MySharedPreferences.id ? const Radius.circular(12.0) : Radius.zero,
                bottomLeft: const Radius.circular(12.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.picture_as_pdf, size: 50, color: Colors.white),
                const SizedBox(height: 20.0),
                Text(
                  chatModel.message!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          if (chatModel.fileUrl == null)
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.50), BlendMode.dstATop),
                child: Material(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          if (chatModel.fileUrl == null)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            )
        ],
      ),
    );
  }
}
