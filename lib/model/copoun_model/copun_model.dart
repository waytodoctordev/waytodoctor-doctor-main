// To parse this JSON data, do
//
//     final copounModel = copounModelFromJson(jsonString);

import 'dart:convert';

CopounModel copounModelFromJson(String str) =>
    CopounModel.fromJson(json.decode(str));

String copounModelToJson(CopounModel data) => json.encode(data.toJson());

class CopounModel {
  CopounModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  CopounData data;

  factory CopounModel.fromJson(Map<String, dynamic> json) => CopounModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: CopounData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class CopounData {
  CopounData({
    required this.id,
    required this.name,
    required this.discountType,
    required this.couponType,
    required this.discount,
    required this.count,
    required this.endDate,
    required this.status,
  });

  int id;
  String name;
  String discountType;
  String couponType;
  double discount;
  int count;
  DateTime endDate;
  int status;

  factory CopounData.fromJson(Map<String, dynamic> json) => CopounData(
        id: json["id"],
        name: json["name"],
        discountType: json["discount_type"],
        couponType: json["coupon_type"],
        discount: json["discount"].toDouble(),
        count: json["count"] ?? 0,
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discount_type": discountType,
        "coupon_type": couponType,
        "discount": discount,
        "count": count,
        "end_date": endDate,
        "status": status,
      };
}
