// To parse this JSON data, do
//
//     final workHoursDataModel = workHoursDataModelFromJson(jsonString);

import 'dart:convert';

WorkHoursDataModel? workHoursDataModelFromJson(String str) => WorkHoursDataModel.fromJson(json.decode(str));

String workHoursDataModelToJson(WorkHoursDataModel? data) => json.encode(data!.toJson());

class WorkHoursDataModel {
  WorkHoursDataModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  DayData? data;

  factory WorkHoursDataModel.fromJson(Map<String, dynamic> json) => WorkHoursDataModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: DayData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class DayData {
  DayData({
    this.id,
    this.name,
    this.startAt,
    this.endAt,
    this.status,
    this.doctorId,
    this.clinicId,
  });

  int? id;
  String? name;
  String? startAt;
  String? endAt;
  int? status;
  int? doctorId;
  int? clinicId;

  factory DayData.fromJson(Map<String, dynamic> json) => DayData(
        id: json["id"],
        name: json["name"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        status: json["status"],
        doctorId: json["doctor_id"],
        clinicId: json["clinic_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_at": startAt,
        "end_at": endAt,
        "status": status,
        "doctor_id": doctorId,
        "clinic_id": clinicId,
      };
}
