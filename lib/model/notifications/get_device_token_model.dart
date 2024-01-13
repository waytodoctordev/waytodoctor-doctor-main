// To parse this JSON data, do
//
//     final getDeviceTokenOfUserModel = getDeviceTokenOfUserModelFromJson(jsonString);

import 'dart:convert';

GetDeviceTokenOfUserModel getDeviceTokenOfUserModelFromJson(String str) =>
    GetDeviceTokenOfUserModel.fromJson(json.decode(str));

String getDeviceTokenOfUserModelToJson(GetDeviceTokenOfUserModel data) =>
    json.encode(data.toJson());

class GetDeviceTokenOfUserModel {
  GetDeviceTokenOfUserModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.note,
  });

  bool status;
  int code;
  String msg;
  Note note;

  factory GetDeviceTokenOfUserModel.fromJson(Map<String, dynamic> json) =>
      GetDeviceTokenOfUserModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        note: Note.fromJson(json["note"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "note": note.toJson(),
      };
}

class Note {
  Note({
    required this.id,
    required this.deviceToken,
  });

  int id;

  String deviceToken;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_token": deviceToken,
      };
}
