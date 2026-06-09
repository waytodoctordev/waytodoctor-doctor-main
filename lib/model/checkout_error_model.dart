// To parse this JSON data, do
//
//     final checkoutErrorModel = checkoutErrorModelFromJson(jsonString);

import 'dart:convert';

CheckoutErrorModel checkoutErrorModelFromJson(String str) =>
    CheckoutErrorModel.fromJson(json.decode(str));

String checkoutErrorModelToJson(CheckoutErrorModel data) =>
    json.encode(data.toJson());

class CheckoutErrorModel {
  CheckoutErrorModel({
    required this.errorCode,
    required this.errorMessage,
    required this.errors,
  });

  int errorCode;
  String errorMessage;
  List<Error> errors;

  factory CheckoutErrorModel.fromJson(Map<String, dynamic> json) =>
      CheckoutErrorModel(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    required this.errorCode,
    required this.errorMessage,
  });

  int errorCode;
  String errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
      };
}
