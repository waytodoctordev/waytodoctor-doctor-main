import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
// import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:way_to_doctor_doctor/controller/chat_ctrl.dart';
import 'package:way_to_doctor_doctor/model/agora_model.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/services/agora_token_service.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/message_bubbles/image_message_bubble.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/message_bubbles/pdf_message_bubble.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/message_bubbles/text_message_bubble.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/message_bubbles/voice_message_bubble.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/components/send_image_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/video_call_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/file_extension.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../utils/icons.dart';
import 'audio_call_screen.dart';

// const token =
   // "007eJxTYFjloiinamk4q1Bvv1xCmqbgtGt/yx7pXpi+uE0u6izn/mkKDGmWhgYpxgYGlhamKSZGRkkWiaaWSUDSIjHZwMTS0iTf+1ByQyAjw8VpL1gYGSAQxOdgSMxITStNzEhjYAAAJSQfsw==";
const token =
    "00685b2caaa870c49ee9b3766a9bbeed471IAB5AM+X2hfUxJ8jaqat852Gm9rj1Ynqv6eLcsCFNelBhwx+f9ij4OObEAAPe4bAsldjZAEAAQBCFGJk";
const channelName = "ahefuahf";

class ChatScreen extends StatefulWidget {
  final int patientId;
  final int appointmentId;
  final String patientName;
  // final AgoraModel agoraModel;
  final String status;

  final String bookingType;
  const ChatScreen({
    Key? key,
    required this.patientId,
    required this.patientName,
    // required this.agoraModel,
    required this.bookingType,
    required this.appointmentId,
    required this.status,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatCollection = FirebaseFirestore.instance.collection('chat');
  late TextEditingController messageCtrl;
  late ScrollController scrollCtrl;
  File? file;
  late Future<String?> initializeRoomId;
  late String myRoomId;

  Future<void> showNoteDialog(bool isVideo, AgoraModel agoraModel) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Note'.tr),
          content: Text('The duration of the call will be 10 minutes.'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Approve'.tr),
              onPressed: () async {
                Navigator.of(context).pop();
                var channelName = const Uuid().v1();
                String? token =
                    await GetAgoraToken().init(channelName, context);
                if (token != null) {
                  ChatCtrl.find.fetchDeviceTokenForCall(
                      context: context,
                      isVideo: isVideo,
                      userId: widget.patientId,
                      channelName: channelName,
                      agormaModel: agoraModel,
                      callToken: token);
                  await FirebaseFirestore.instance
                      .collection('chat')
                      .doc('${widget.patientId}${MySharedPreferences.id}')
                      .update({
                    'token': token,
                    'channelName': channelName,
                  });
                  if (isVideo) {
                    Get.to(
                      () => VideoCallScreen(
                        token: token,
                        channelName: channelName,
                        isVideo: true,
                        patientName: widget.patientName,
                        patientId: widget.patientId,
                      ),
                    )!
                        .then((value) {
                      Get.back();
                    });
                  } else {
                    Get.to(
                      () => AudioCallScreen(
                        token: token,
                        channelName: channelName,
                        patientName: widget.patientName,
                        patientId: widget.patientId,
                      ),
                    )!
                        .then((value) {
                      Get.back();
                    });
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  //Image.file(File(pickedFile.path!)),
  Future<void> _pdfDialog(PlatformFile pickedFile) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.picture_as_pdf, size: 50),
              const SizedBox(height: 20.0),
              Text(pickedFile.name),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Send'.tr),
              onPressed: () {
                Get.back();
                _sendMessage(
                    message: pickedFile.name,
                    type: MessageType.pdf,
                    pickedFile: pickedFile);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'pdf'],
    );
    if (result != null) {
      final pickedFile = result.files.single;
      final extension = pickedFile.extension!;
      log("extension:: $extension");
      switch (extension) {
        case 'pdf':
          _pdfDialog(pickedFile);
          break;
        case 'png':
        case 'jpg':
          int? imageHeight;
          int? imageWidth;
          Get.to(() => SendImageScreen(imagePath: pickedFile.path!))!
              .then((value) {
            if (value == 'send') {
              _sendMessage(
                  message: pickedFile.name,
                  type: MessageType.image,
                  pickedFile: pickedFile,
                  imageHeight: imageHeight!,
                  imageWidth: imageWidth!);
            }
          });
          final buffer = await ImmutableBuffer.fromUint8List(
              File(pickedFile.path!).readAsBytesSync());
          final descriptor = await ImageDescriptor.encoded(buffer);
          imageHeight = descriptor.height;
          imageWidth = descriptor.width;
          log("imageHeight: $imageHeight, imageWidth: $imageWidth");
          break;
      }
    }
  }

  Future _uploadFile(PlatformFile pickedFile, String documentId) async {
    var storageImage = await FirebaseStorage.instance
        .ref(myRoomId)
        .child('files/${pickedFile.name}')
        .putFile(File(pickedFile.path!));
    var downloadUrl = await storageImage.ref.getDownloadURL();
    chatCollection
        .doc(myRoomId)
        .collection('messages${widget.appointmentId}')
        .doc(documentId)
        .update({
      'fileUrl': downloadUrl,
    }).whenComplete(() => log(downloadUrl));
  }

  Future<void> _sendMessage(
      {required String message,
      required String type,
      required PlatformFile? pickedFile,
      int? imageHeight,
      int? imageWidth}) async {
    DateTime serverTime;
    serverTime = await NTP.now();
    late Future<DocumentReference<Map<String, dynamic>>> initializeDocument;
    initializeDocument = chatCollection
        .doc(myRoomId)
        .collection('messages${widget.appointmentId}')
        .add({
      'userId': MySharedPreferences.id,
      'createdAt': serverTime, // TODO CHANGED
      'message': message,
      'type': type,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
    });
    scrollCtrl.animateTo(
      scrollCtrl.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );

    messageCtrl.clear();
    if (type != MessageType.text) {
      var document = await initializeDocument;
      await _uploadFile(pickedFile!, document.id);
      await ChatCtrl.find.fetchDeviceTokenForChat(
          status: 'CHAT',
          mbody: type,
          appointmentStatus: widget.status,
          title: MySharedPreferences.fName,
          userId: widget.patientId,
          context: context,
          bookingType: widget.bookingType,
          appointmentId: widget.appointmentId);
      // await SendNotification()
      //     .data(MySharedPreferences.fName, type, widget.patientId.toString());
    } else {
      await ChatCtrl.find.fetchDeviceTokenForChat(
          status: 'CHAT',
          mbody: message,
          title: MySharedPreferences.fName,
          userId: widget.patientId,
          appointmentStatus: widget.status,
          context: context,
          bookingType: widget.bookingType,
          appointmentId: widget.appointmentId);
      // await SendNotification().data(
      //     MySharedPreferences.fName, message, widget.patientId.toString());
    }
  }

  Future<String?> getRoomId() async {
    var roomId = '${widget.patientId}${MySharedPreferences.id}';
    try {
      final document = await chatCollection.doc(roomId).get();
      if (document.exists) {
        myRoomId = document.id;
      } else {
        await chatCollection.doc(roomId).set({
          'roomId': roomId,
          'createdAt': DateTime.now(),
        });
        myRoomId = roomId;
      }
      return myRoomId;
    } catch (e) {
      log('ERROR:: $e');
      return null;
    }
  }

  Widget _toggleMessageBubble(ChatModel chatModel, int index) {
    switch (chatModel.type) {
      case MessageType.pdf:
        {
          return PdfMessageBubble(
              chatModel: chatModel, doctorId: widget.patientId);
        }
      case MessageType.image:
        {
          return ImageMessageBubble(chatModel: chatModel, index: index);
        }

      case MessageType.voice:
        return VoiceMessageBubble(
            chatModel: chatModel, doctorId: widget.patientId);
      default:
        {
          return TextMessageBubble(
              chatModel: chatModel, doctorId: widget.patientId);
        }
    }
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(ChatCtrl.find.recordDuration ~/ 60);
    final String seconds = _formatNumber(ChatCtrl.find.recordDuration % 60);
    return Text(
      MySharedPreferences.language == 'ar'
          ? '$seconds : $minutes'
          : '$minutes : $seconds',
      style: const TextStyle(
        color: MyColors.blue14B,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  @override
  void initState() {
    Get.put(ChatCtrl());
    messageCtrl = TextEditingController();
    scrollCtrl = ScrollController();
    initializeRoomId = getRoomId();
    super.initState();
  }

  @override
  void dispose() {
    messageCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.bookingType);
    return FutureBuilder<String?>(
      future: initializeRoomId,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Material(
              child: Center(
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
              ),
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.patientName),
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: RotatedBox(
                      quarterTurns: 3,
                      child: SvgPicture.asset(
                        MyIcons.angleSmallRight,
                        color: MyColors.blue14B,
                      ),
                    ),
                  ),
                  actions: [
                    StreamBuilder(
                      stream: AppConstants().fireAgoraStreamForCall(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox.shrink();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        final agoraModel2 = snapshot.data!.docs[0].data();
                        // log(agoraModel2.isActive.toString());
                        // log(agoraModel2.doctorId.toString());
                        // log(agoraModel2.patientId.toString());
                        // log(agoraModel2.doctorName.toString());
                        // log(agoraModel2.id.toString());
                        // log(agoraModel2.roomId.toString());
                        // log(agoraModel2.isActive.toString());
                        // log(agoraModel2.isActive.toString());
                        if (agoraModel2.isActive &&
                            //     widget.bookingType == AppConstants.call ||
                            // widget.bookingType == AppConstants.video ||
                            widget.bookingType == AppConstants.chat) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showNoteDialog(false, agoraModel2);
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showNoteDialog(true, agoraModel2);
                                },
                                icon: const Icon(
                                  Icons.videocam,
                                  color: MyColors.primary,
                                ),
                              ),
                            ],
                          );
                        }

                        if (agoraModel2.isActive &&
                            widget.bookingType == AppConstants.call) {
                          return IconButton(
                            onPressed: () {
                              showNoteDialog(false, agoraModel2);
                            },
                            icon: const Icon(
                              Icons.call,
                              color: MyColors.primary,
                            ),
                          );
                        }

                        if (agoraModel2.isActive &&
                            widget.bookingType == AppConstants.video) {
                          return IconButton(
                            onPressed: () {
                              showNoteDialog(true, agoraModel2);
                            },
                            icon: const Icon(
                              Icons.videocam,
                              color: MyColors.primary,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                body: Column(
                  children: [
                    Expanded(
                      child: FirestoreQueryBuilder<ChatModel>(
                        pageSize: 20,
                        query: chatCollection
                            .doc(snapshot.data!)
                            .collection('messages${widget.appointmentId}')
                            .orderBy('createdAt', descending: true)
                            .withConverter<ChatModel>(
                              fromFirestore: (snapshot, _) =>
                                  ChatModel.fromJson(snapshot.data()!),
                              toFirestore: (message, _) => message.toJson(),
                            ),
                        builder: (context, snapshot, _) {
                          if (snapshot.isFetching) {
                            return const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )),
                            );
                          }

                          if (snapshot.hasError) {
                            return Text(
                                'Something went wrong! ${snapshot.error}');
                          }

                          return ListView.separated(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            controller: scrollCtrl,
                            reverse: true,
                            padding: const EdgeInsets.all(20.0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: snapshot.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.hasMore &&
                                  index + 1 == snapshot.docs.length) {
                                snapshot.fetchMore();
                              }

                              final data = snapshot.docs[index].data();
                              return Align(
                                alignment: data.userId == MySharedPreferences.id
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width / 1.5),
                                  child: _toggleMessageBubble(data, index),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    GetBuilder<ChatCtrl>(
                      builder: (controller) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              controller.isVoiceRecording
                                  ? SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FloatingActionButton(
                                        heroTag: 'trash',
                                        backgroundColor: MyColors.red,
                                        onPressed: () {
                                          controller.stop(context);
                                        },
                                        child: const Icon(
                                          CupertinoIcons.trash,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FloatingActionButton(
                                        heroTag: 'file',
                                        backgroundColor: MyColors.blue14B,
                                        onPressed: () {
                                          _pickFile();
                                        },
                                        child: const Icon(
                                          Icons.image,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                              const SizedBox(width: 10.0),
                              controller.isVoiceRecording
                                  ? Expanded(child: _buildTimer())
                                  : Expanded(
                                      child: CustomTextField(
                                        controller: messageCtrl,
                                        onChanged: (p0) {
                                          if (p0.isEmpty) {
                                            ChatCtrl.find.setIsMic(true);
                                          } else {
                                            ChatCtrl.find.setIsMic(false);
                                          }
                                        },
                                        horizontalPadding: 20,
                                      ),
                                    ),
                              const SizedBox(width: 10.0),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: FloatingActionButton(
                                  heroTag: 'send',
                                  backgroundColor: MyColors.blue14B,
                                  onPressed: () {
                                    if (controller.isMic) {
                                      if (!controller.recorder.isRecording) {
                                        controller.start(context);
                                      } else {
                                        controller.stop(context).whenComplete(
                                          () {
                                            return _sendMessage(
                                              message:
                                                  controller.voiceFile.name,
                                              type: MessageType.voice,
                                              pickedFile: controller.voiceFile,
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      _sendMessage(
                                        message: messageCtrl.text.trim(),
                                        type: MessageType.text,
                                        pickedFile: null,
                                      );
                                      ChatCtrl.find.setIsMic(true);
                                    }
                                  },
                                  child: controller.isMic &&
                                          !controller.isVoiceRecording
                                      ? const Icon(Icons.mic)
                                      : controller.isMic &&
                                              controller.isVoiceRecording
                                          ? const Icon(
                                              Icons.send_rounded,
                                              size: 20,
                                            )
                                          : !controller.isMic
                                              ? const Icon(
                                                  Icons.send,
                                                  size: 20,
                                                )
                                              : const Icon(
                                                  Icons.send,
                                                  size: 20,
                                                ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Material(child: FailedWidget());
            }
        }
      },
    );
  }

  // Future<bool> _onWillPop() async {
  //   final shouldPop = await showDialog<bool>(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Do you want to go back?'),
  //         actionsAlignment: MainAxisAlignment.spaceBetween,
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, true);
  //             },
  //             child: const Text('Yes'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, false);
  //             },
  //             child: const Text('No'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   return shouldPop!;
  // }
}
