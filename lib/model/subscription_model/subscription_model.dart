// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/plans_model/plans_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  SubscriptionModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  Data data;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.user,
    required this.plan,
    required this.orderNumber,
  });

  int id;
  DateTime startDate;
  DateTime endDate;
  String orderNumber;
  User user;
  Plan plan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orderNumber: json["order_number"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        user: User.fromJson(json["user"]),
        plan: Plan.fromJson(json["plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "user": user.toJson(),
        "plan": plan.toJson(),
      };
}
