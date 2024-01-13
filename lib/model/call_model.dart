import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  final Timestamp createdAt;
  // final Timestamp callTime;
  final int doctorId;
  final int patientId;
  final String roomId;
  final String token;
  final String accessToken;
  // final int id;
  final String channelName;
  final String patientName;
  final String patientImage;
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final String callStatus;

  CallModel({
    required this.createdAt,
    required this.token,
    required this.accessToken,
    required this.channelName,
    required this.doctorId,
    required this.patientId,
    required this.roomId,
    required this.callStatus,
    required this.doctorImage,
    required this.doctorSpecialization,
    required this.patientImage,
    required this.patientName,
    required this.doctorName,
  });

  static CallModel fromJson(Map<String, dynamic> json) => CallModel(
        createdAt: json['createdAt'],
        callStatus: json['callStatus'],
        accessToken: json['accessToken'],
        patientName: json['patientName'],
        doctorName: json['doctorName'] ?? '',
        channelName: json['channelName'],
        doctorId: json['doctorId'] ?? 0,
        doctorImage: json['doctorImage'] ?? '',
        patientId: json['patientId'] ?? 0,
        token: json['token'] ?? '',
        roomId: json['roomId'] ?? '',
        doctorSpecialization: json['isActive'] ?? '',
        patientImage: json['canCall'] ?? '',
      );

  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'patientImage': patientImage,
      'accessToken': accessToken,
      'doctorImage': doctorImage,
      'doctorId': doctorId,
      'patientId': patientId,
      'token': token,
      'callStatus': callStatus,
      'roomId': roomId,
      'channelName': channelName,
      'doctorSpecialization': doctorSpecialization,
      'patientName': patientName,
      'doctorName': doctorName,
    };
  }
}
