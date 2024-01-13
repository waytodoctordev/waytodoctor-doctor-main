// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/registration/sign_up_model.dart';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
      };
}

// class User {
//   User({
//     this.id,
//     this.name,
//     this.lastName,
//     this.phone,
//     this.email,
//     this.deviceToken,
//     this.image,
//   });

//   int? id;
//   String? name;
//   String? lastName;
//   String? phone;
//   String? email;
//   String? deviceToken;
//   String? image;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         lastName: json["last_name"],
//         phone: json["phone"],
//         email: json["email"],
//         deviceToken: json["device_token"],
//         image: json["image"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "last_name": lastName,
//         "phone": phone,
//         "email": email,
//         "device_token": deviceToken,
//         "image": image,
//       };
// }
