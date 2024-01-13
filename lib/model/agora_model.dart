import 'package:cloud_firestore/cloud_firestore.dart';

class AgoraModel {
  final Timestamp createdAt;
  final Timestamp callTime;
  final int doctorId;
  final int id;
  final int patientId;
  final String roomId;
  final String token;
  final String channelName;
  final String patientName;
  final String doctorName;
  final bool isActive;
  final bool canCall;

  AgoraModel({
    required this.createdAt,
    required this.callTime,
    required this.token,
    required this.id,
    required this.channelName,
    required this.doctorId,
    required this.patientId,
    required this.roomId,
    required this.isActive,
    required this.canCall,
    required this.patientName,
    required this.doctorName,
  });

  static AgoraModel fromJson(Map<String, dynamic> json) => AgoraModel(
        createdAt: json['createdAt'],
        callTime: json['callTime'],
        patientName: json['patientName'] ?? '',
        doctorName: json['doctorName'] ?? '',
        channelName: json['channelName'] ?? '',
        doctorId: json['doctorId'] ?? 0,
        id: json['id'] ?? 0,
        patientId: json['patientId'] ?? 0,
        token: json['token'] ?? '',
        roomId: json['roomId'] ?? '',
        isActive: json['isActive'] ?? false,
        canCall: json['canCall'] ?? false,
      );

  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'callTime': callTime,
      'doctorId': doctorId,
      'patientId': patientId,
      'token': token,
      'id': id,
      'roomId': roomId,
      'channelName': channelName,
      'isActive': isActive,
      'canCall': canCall,
      'patientName': patientName,
      'doctorName': doctorName,
    };
  }
}
