// To parse this JSON data, do
//
//     final plansModel = plansModelFromJson(jsonString);

import 'dart:convert';

PlansModel? plansModelFromJson(String str) =>
    PlansModel.fromJson(json.decode(str));

String plansModelToJson(PlansModel? data) => json.encode(data!.toJson());

class PlansModel {
  PlansModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Plan>? data;

  factory PlansModel.fromJson(Map<String, dynamic> json) => PlansModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<Plan>.from(json["data"]!.map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Plan {
  Plan({
    this.id,
    this.name,
    this.details,
    this.price,
    this.isActive,
    this.time,
  });

  int? id;
  String? name;
  String? details;
  String? price;
  int? isActive;
  int? time;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        name: json["name"],
        details: json["details"],
        isActive: json["is_active"],
        price: json["price"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
        "price": price,
        "is_active": isActive,
        "time": time,
      };
}
