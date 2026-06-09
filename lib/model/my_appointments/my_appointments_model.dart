// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:way_to_doctor_doctor/model/my_appointments/doctors_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';

MyAppointmentsModel appointmentModelFromJson(String str) =>
    MyAppointmentsModel.fromJson(json.decode(str));

String appointmentModelToJson(MyAppointmentsModel data) =>
    json.encode(data.toJson());

class MyAppointmentsModel {
  MyAppointmentsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<AppointmentData>? data;

  factory MyAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      MyAppointmentsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<AppointmentData>.from(
            json["data"].map((x) => AppointmentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<AppointmentData>.from(data!.map((x) => x.toJson())),
      };
}

class AppointmentData {
  AppointmentData({
    this.id,
    this.time,
    this.date,
    this.status,
    this.type,
    this.bookingType,
    this.location,
    this.caseDescription,
    this.clinicId,
    this.doctor,
    this.user,
    this.files,
    this.replays,
    this.doctorDescription,
    this.paymentMethod,
    this.paymentAccount,
    this.userReplays,
    this.userMedicalHistory,

  });

  int? id;
  String? time;
  DateTime? date;
  String? status;
  String? type;
  String? paymentMethod;
  String? paymentAccount;
  String? bookingType;
  String? location;
  String? caseDescription;
  Doctors? doctor;
  User? user;
  int? clinicId;
  List<FileElement>? files;
  List<DoctorDescription>? replays;
  List<DoctorDescription>? doctorDescription;
  List<DoctorDescription>? userReplays;
  UserMedicalHistory? userMedicalHistory;


  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      AppointmentData(
          id: json["id"],
          time: json["time"],
          date: DateTime.parse(json["date"]),
          status: json["status"],
          paymentMethod: json["payment_method"],
          paymentAccount: json["payment_account"],
          type: json["type"],
          bookingType: json["booking_type"],
          location: json["location"],
          caseDescription: json["case_description"],
          doctor: Doctors.fromJson(json["doctor"]),
          user: User.fromJson(json["user"]),
          clinicId: json["clinic_id"],
          files: List<FileElement>.from(
              json["files"].map((x) => FileElement.fromJson(x))),
          replays: json["replays"] == null
              ? []
              : List<DoctorDescription>.from(
                  json["replays"]!.map((x) => DoctorDescription.fromJson(x))),
          doctorDescription: json["doctor_description"] == null
              ? []
              : List<DoctorDescription>.from(json["doctor_description"]!
                  .map((x) => DoctorDescription.fromJson(x))),
          userReplays: json["user_replays"] == null
              ? []
              : List<DoctorDescription>.from(json["user_replays"]!
                  .map((x) => DoctorDescription.fromJson(x))),
            userMedicalHistory: UserMedicalHistory.fromJson(json["user_medical_history"]));


  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "type": type,
        "payment_method": paymentMethod,
        "payment_account": paymentAccount,
        "booking_type": bookingType,
        "location": location,
        "case_description": caseDescription,
        "doctor": doctor!.toJson(),
        "user": user!.toJson(),
        "clinic_id": clinicId,
        "files": List<File>.from(files!.map((x) => x.toJson())),
        "replays": replays == null
            ? []
            : List<dynamic>.from(replays!.map((x) => x.toJson())),
        "doctor_description": doctorDescription == null
            ? []
            : List<dynamic>.from(doctorDescription!.map((x) => x.toJson())),
        "user_replays": userReplays == null
            ? []
            : List<dynamic>.from(userReplays!.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    this.id,
    this.file,
    this.appointment,
  });

  int? id;
  String? file;
  int? appointment;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        file: json["file"],
        appointment: json["appointment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "appointment": appointment,
      };
}

class DoctorDescription {
  DoctorDescription({
    this.id,
    this.content,
    this.date,
    this.file,
    this.appointment,
  });

  int? id;
  String? content;
  DateTime? date;
  String? file;
  int? appointment;

  factory DoctorDescription.fromJson(Map<String, dynamic> json) =>
      DoctorDescription(
        id: json["id"],
        content: json["content"],
        date: DateTime.parse(json["date"]),
        file: json["file"],
        appointment: json["appointment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "file": file,
        "appointment": appointment,
      };
}
class UserMedicalHistory {
  int doctorId;
  int userId;
  List<FileElement> files;
  List<DoctorDescription> replays;
  List<DoctorDescription> doctorDescription;
  List<DoctorDescription> userReplays;

  UserMedicalHistory({
    required this.doctorId,
    required this.userId,
    required this.files,
    required this.replays,
    required this.doctorDescription,
    required this.userReplays,
  });

  factory UserMedicalHistory.fromJson(Map<String, dynamic> json) => UserMedicalHistory(
    doctorId: json["doctor_id"],
    userId: json["user_id"],
    files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    replays: List<DoctorDescription>.from(json["replays"].map((x) => DoctorDescription.fromJson(x))),
    doctorDescription: List<DoctorDescription>.from(json["doctor_description"].map((x) => DoctorDescription.fromJson(x))),
    userReplays: List<DoctorDescription>.from(json["user_replays"].map((x) => DoctorDescription.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "user_id": userId,
    "files": List<dynamic>.from(files.map((x) => x.toJson())),
    "replays": List<dynamic>.from(replays.map((x) => x.toJson())),
    "doctor_description": List<dynamic>.from(doctorDescription.map((x) => x.toJson())),
    "user_replays": List<dynamic>.from(userReplays.map((x) => x.toJson())),
  };
}