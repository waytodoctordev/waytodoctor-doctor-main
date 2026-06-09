import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/model/chat_model.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class TextMessageBubble extends StatelessWidget {
  final ChatModel chatModel;
  final int doctorId;

  const TextMessageBubble({
    super.key,
    required this.chatModel,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color:
            chatModel.userId == doctorId.toString() ? MyColors.primary : MyColors.blue9D1,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(18.0),
          bottomRight: chatModel.userId == doctorId.toString()
              ? const Radius.circular(18.0)
              : const Radius.circular(4.0),
          topLeft: chatModel.userId == MySharedPreferences.id.toString()
              ? const Radius.circular(18.0)
              : const Radius.circular(4.0),
          bottomLeft: const Radius.circular(18.0),
        ),
      ),
      child: Text(
        chatModel.message!,
        style: TextStyle(
            color: chatModel.userId == doctorId.toString() ? Colors.white : Colors.black),
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:way_to_doctor_doctor/model/chat_model.dart';
// import 'package:way_to_doctor_doctor/utils/colors.dart';
// import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
// import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';

// class TextMessageBubble extends StatefulWidget {
//   final ChatModel chatModel;
//   final int doctorId;

//   const TextMessageBubble({
//     super.key,
//     required this.chatModel,
//     required this.doctorId,
//   });

//   @override
//   State<TextMessageBubble> createState() => _TextMessageBubbleState();
// }

// class _TextMessageBubbleState extends State<TextMessageBubble> {
//   final _controller = ReactionsController(currentUserId: '1');
//   bool isMe = false;
//   ChatReactionsConfig config = ChatReactionsConfig(
//     enableHapticFeedback: true,
//     maxReactionsToShow: 3,
//     showContextMenu: true,
//     enableDoubleTap: true,
//   );

//   Future<void> _addReaction({
//     required ChatModel msg,
//     required String reaction,
//   }) async {
//     print('msg.userId ${msg.userId}');
//     print('reaction $reaction');

//     final uid = FirebaseAuth.instance.currentUser!.uid;

// print(uid);
//     final docRef = FirebaseFirestore.instance
//         .collection('chats')
//         .doc('roomId') // adjust to your room
//         .collection('messages')
//         .doc(msg.cratedAt.toString());//message ID

//     await docRef.set({
//       'reactions': {
//         uid: reaction,
//       }
//     }, SetOptions(merge: true));
//   }
// //await docRef.update({
// //   'reactions.$uid': FieldValue.delete(),
// // });
//   Future<void> _removeReaction({
//     required ChatModel msg,
//     required String reaction,
//   }) async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;

//     final docRef = FirebaseFirestore.instance
//         .collection('chats')
//         .doc('roomId')
//         .collection('messages')
//         .doc(msg.userId.toString());

//     await docRef.update({
//       'reactions.$uid': FieldValue.delete(),
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     isMe = widget.chatModel.userId == widget.doctorId;

//     // Load initial reactions
//     // for (final message in Message.messages) {
//     //   for (final reaction in message.reactions) {
//     //     _controller.addReaction(message.id, reaction);
//     //   }
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return   StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("chats")
//           .doc("roomId")
//           .collection("messages")
//           .doc(widget.chatModel.cratedAt.toString())
//           .snapshots(),
//       builder: (ctx, snap) {
//         if (!snap.hasData) return Text('no message');

//         final data = snap.data!.data() as Map<String, dynamic>? ?? {};
//         final reactions = Map<String, dynamic>.from(data["reactions"] ?? {});

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//         GestureDetector(
//             onLongPress: () async {}
//             //   Navigator.of(context).push(
//             //     HeroDialogRoute(builder: (context) {
//             //       return ReactionsDialogWidget(
//             //         // key: ,
//             //         messageId: widget.chatModel.cratedAt.toString(),
//             //        controller: _controller,
//             // config:config,
//             //         messageWidget: MessageWidget(message:widget.chatModel.message),
//             //         onReactionTap: (reaction) {
//             //           // if (reaction == '➕') {
//             //   showEmojiContainer(
//             //     messageId: element.messageId,
//             //   );
//             // } else {
//             //   sendReactionToMessage(
//             //     reaction: reaction,
//             //     messageId: element.messageId,
//             //   );
//             //   // }
//             // },
//             // onContextMenuTap: (item) {
//             //   onContextMenyClicked(
//             //     item: item.label,
//             //     message: message,
//             //   );
//             // },
//             // widgetAlignment:
//             //     isMe ? Alignment.centerRight : Alignment.centerLeft,
//             // );
//             // }),
        
//             // }
//             ,
//             child: ChatMessageWrapper(
//               messageId: widget.chatModel.cratedAt.toString(),
//               controller: _controller,
//               config: config,
//               onReactionAdded: (r) =>
//                   _addReaction(msg: widget.chatModel, reaction: r),
//               onReactionRemoved: (r) =>
//                   _removeReaction(msg: widget.chatModel, reaction: r),
//               onMenuItemTapped: (item) {
//                 switch (item.label) {
//                   case 'Reply':
//                     // handle reply
//                     break;
//                   case 'Copy':
//                     // copy message
//                     break;
//                   case 'Delete':
//                     // any delete logic
//                     break;
//                 }
//               },
//               child: Container(
//                 // margin: const EdgeInsets.symmetric(horizontal: 8),
//                 padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//                 color: widget.chatModel.userId == widget.doctorId
//                     ? MyColors.blue9D1
//                     : MyColors.primary,
//                 borderRadius: BorderRadius.only(
//                   topRight: const Radius.circular(18.0),
//                   bottomRight: widget.chatModel.userId == widget.doctorId
//                       ? const Radius.circular(18.0)
//                       : const Radius.circular(4.0),
//                   topLeft: widget.chatModel.userId == MySharedPreferences.id
//                       ? const Radius.circular(18.0)
//                       : const Radius.circular(4.0),
//                   bottomLeft: const Radius.circular(18.0),
//                 ),
//               ),
//                 child: Text(
//                   widget.chatModel.message.toString(),
//                   style: TextStyle(
//                       decoration: TextDecoration.none,
//                       color: widget.chatModel.userId == widget.doctorId
//                           ? Colors.black87
//                           : Colors.white,
        
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//       });}
// }
