// To parse this JSON data, do
//
//     final updateAppointmentModel = updateAppointmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/user/user_model.dart';

UpdateAppointmentModel? updateAppointmentModelFromJson(String str) =>
    UpdateAppointmentModel.fromJson(json.decode(str));

String updateAppointmentModelToJson(UpdateAppointmentModel? data) =>
    json.encode(data!.toJson());

class UpdateAppointmentModel {
  UpdateAppointmentModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  UpdateAppoientmentData? data;

  factory UpdateAppointmentModel.fromJson(Map<String, dynamic> json) =>
      UpdateAppointmentModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: UpdateAppoientmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class UpdateAppoientmentData {
  UpdateAppoientmentData({
    this.id,
    this.time,
    this.date,
    this.status,
    this.type,
    this.user,
    this.paymentMethod,
    this.bookingType,
    this.location,
  });

  int? id;
  String? time;
  DateTime? date;
  String? status;
  String? paymentMethod;
  String? type;
  String? bookingType;
  String? location;
  User? user;

  factory UpdateAppoientmentData.fromJson(Map<String, dynamic> json) =>
      UpdateAppoientmentData(
        id: json["id"],
        time: json["time"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        paymentMethod: json["payment_method"],
        type: json["type"],
        user: User.fromJson(json["user"]),
        bookingType: json["booking_type"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "payment_method": paymentMethod,
        "type": type,
        "user": user!.toJson(),
        "booking_type": bookingType,
        "location": location,
      };
}
