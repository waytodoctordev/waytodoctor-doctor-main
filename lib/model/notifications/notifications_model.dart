// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel? notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel? data) =>
    json.encode(data!.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<NotificationsData>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<NotificationsData>.from(
            json["data"]!.map((x) => NotificationsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationsData {
  NotificationsData({
    this.id,
    this.content,
    this.type,
    this.routeId,
    this.createdAt,
    // this.user,
  });

  int? id;
  String? content;
  String? type;
  int? routeId;
  String? createdAt;
  // User? user;

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      NotificationsData(
        id: json["id"],
        content: json["content"],
        type: json["type"],
        createdAt: json["created_at"],
        routeId: json["route_id"],
        // user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "route_id": routeId,
        "created_at": createdAt,
        "type": type,
        // "user": user!.toJson(),
      };
}
