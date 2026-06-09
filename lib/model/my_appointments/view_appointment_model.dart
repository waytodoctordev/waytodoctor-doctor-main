// To parse this JSON data, do
//
//     final viewAppointmentModel = viewAppointmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';

ViewAppointmentModel viewAppointmentModelFromJson(String str) => ViewAppointmentModel.fromJson(json.decode(str));

String viewAppointmentModelToJson(ViewAppointmentModel data) => json.encode(data.toJson());

class ViewAppointmentModel {
  ViewAppointmentModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  AppointmentData data;

  factory ViewAppointmentModel.fromJson(Map<String, dynamic> json) => ViewAppointmentModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: AppointmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}
