// To parse this JSON data, do
//
//     final appointmentCounterModel = appointmentCounterModelFromJson(jsonString);

import 'dart:convert';

AppointmentCounterModel? appointmentCounterModelFromJson(String str) => AppointmentCounterModel.fromJson(json.decode(str));

String appointmentCounterModelToJson(AppointmentCounterModel? data) => json.encode(data!.toJson());

class AppointmentCounterModel {
  AppointmentCounterModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  CounterData? data;

  factory AppointmentCounterModel.fromJson(Map<String, dynamic> json) => AppointmentCounterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: CounterData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class CounterData {
  CounterData({
    this.completed,
    this.notCompleted,
  });

  int? completed;
  int? notCompleted;

  factory CounterData.fromJson(Map<String, dynamic> json) => CounterData(
        completed: json["completed"],
        notCompleted: json["notCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "notCompleted": notCompleted,
      };
}
