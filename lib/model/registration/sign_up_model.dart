// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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

class User {
  User({
    this.id,
    this.name,
    this.secondName,
    this.thirdName,
    this.lastName,
    this.phone,
    this.email,
    this.nationality,
    this.country,
    this.city,
    this.nationalId,
    this.dateOfBirth,
    this.gender,
    this.status,
    this.image,
  });

  int? id;
  String? name;
  String? secondName;
  String? thirdName;
  String? lastName;
  String? phone;
  String? email;
  String? nationality;
  String? country;
  String? city;
  String? nationalId;
  String? dateOfBirth;
  String? gender;
  String? status;
  String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        secondName: json["second_name"],
        thirdName: json["third_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        nationality: json["nationality"],
        country: json["country"],
        city: json["city"],
        nationalId: json["national_id"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        status: json["status"],
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "second_name": secondName,
        "third_name": thirdName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "nationality": nationality,
        "country": country,
        "city": city,
        "national_id": nationalId,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "status": status,
        "image": image,
      };
}
