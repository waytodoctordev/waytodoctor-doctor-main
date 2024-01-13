import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/view_image_screen.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class ImageMessageBubble extends StatelessWidget {
  final ChatModel chatModel;
  final int index;

  const ImageMessageBubble({
    Key? key,
    required this.chatModel,
    required this.index,
  }) : super(key: key);

  Widget getPlaceHolder() {
    return Image.asset(
      MyImages.wayToDoctorLogo,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: chatModel.fileUrl == null
          ? getPlaceHolder()
          : GestureDetector(
              onTap: () {
                Get.to(
                  () => ViewImageScreen(
                    imageUrl: chatModel.fileUrl!,
                    heroTag: '159$index',
                  ),
                );
              },
              child: Hero(
                tag: '159$index',
                child:  CachedNetworkImage(
                  imageUrl: chatModel.fileUrl!.isNotEmpty
                      ? chatModel.fileUrl!
                      : '',
                  placeholder: (context, url) => getPlaceHolder(),
                  errorWidget: (context, url, error) => getPlaceHolder(),
                ),
              ),
            ),
    );
  }
}
