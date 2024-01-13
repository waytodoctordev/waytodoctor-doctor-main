// To parse this JSON data, do
//
//     final workHoursModel = workHoursModelFromJson(jsonString);

import 'dart:convert';

WorkHoursModel? workHoursModelFromJson(String str) => WorkHoursModel.fromJson(json.decode(str));

String workHoursModelToJson(WorkHoursModel? data) => json.encode(data!.toJson());

class WorkHoursModel {
  WorkHoursModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<WorkHoursData>? data;

  factory WorkHoursModel.fromJson(Map<String, dynamic> json) => WorkHoursModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<WorkHoursData>.from(json["data"]!.map((x) => WorkHoursData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WorkHoursData {
  WorkHoursData({
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

  factory WorkHoursData.fromJson(Map<String, dynamic> json) => WorkHoursData(
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
