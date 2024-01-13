// To parse this JSON data, do
//
//     final createPaymentModel = createPaymentModelFromJson(jsonString);

import 'dart:convert';

CreatePaymentModel? createPaymentModelFromJson(String str) =>
    CreatePaymentModel.fromJson(json.decode(str));

String createPaymentModelToJson(CreatePaymentModel? data) =>
    json.encode(data!.toJson());

class CreatePaymentModel {
  CreatePaymentModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  PaymentData? data;

  factory CreatePaymentModel.fromJson(Map<String, dynamic> json) =>
      CreatePaymentModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: PaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class PaymentData {
  PaymentData({
    this.id,
    this.name,
    this.doctorId,
  });

  int? id;
  String? name;
  int? doctorId;

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        id: json["id"],
        name: json["name"],
        doctorId: json["doctor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doctor_id": doctorId,
      };
}
