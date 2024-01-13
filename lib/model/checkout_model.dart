// To parse this JSON data, do
//
//     final checkoutDoneModel = checkoutDoneModelFromJson(jsonString);

import 'dart:convert';

CheckoutDoneModel checkoutDoneModelFromJson(String str) =>
    CheckoutDoneModel.fromJson(json.decode(str));

String checkoutDoneModelToJson(CheckoutDoneModel data) =>
    json.encode(data.toJson());

class CheckoutDoneModel {
  CheckoutDoneModel({
    required this.redirectUrl,
  });

  String redirectUrl;

  factory CheckoutDoneModel.fromJson(Map<String, dynamic> json) =>
      CheckoutDoneModel(
        redirectUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
      };
}
