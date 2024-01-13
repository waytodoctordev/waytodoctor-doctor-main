import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final Timestamp? cratedAt;
  final String? message;
  final int? userId;
  final String? type;
  final String? fileUrl;
  final int? imageHeight;
  final int? imageWidth;

  const ChatModel({
    required this.cratedAt,
    required this.message,
    required this.userId,
    required this.type,
    required this.fileUrl,
    required this.imageHeight,
    required this.imageWidth,
  });

  static ChatModel fromJson(Map<String, dynamic> json) => ChatModel(
        cratedAt: json['createdAt'],
        message: json['message'],
        userId: json['userId'],
        type: json['type'],
        fileUrl: json['fileUrl'],
        imageHeight: json['imageHeight'],
        imageWidth: json['imageWidth'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': cratedAt,
        'message': message,
        'userId': userId,
        'type': type,
        'fileUrl': fileUrl,
        'imageHeight': imageHeight,
        'imageWidth': imageWidth,
      };
}
