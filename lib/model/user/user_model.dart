// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

// user model
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.code,
    this.msg,
    this.user,
  });

  bool? status;
  int? code;
  String? msg;
  User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
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
    this.active,
    this.step,
    this.questionNumber,
    this.insurance,
    this.subscriptionId,
    this.isBlock,
    this.isSubscriped,
    this.insuranceName,
  });

  int? id;
  bool? isBlock;
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
  bool? isSubscriped;
  String? subscriptionId;
  String? image;
  String? step;
  String? insurance;
  String? insuranceName;
  String? questionNumber;
  String? active;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        isBlock: json["block"],
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
        subscriptionId: json["subscription_order_number"] ?? '',
        isSubscriped: json["is_sub"],
        image: json["image"],
        step: json["step"],
        insuranceName: json["insurance_name"],
        insurance: json["insurance"],
        questionNumber: json["question_number"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "block": isBlock,
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
        "subscription_order_number": subscriptionId,
        "is_sub": isSubscriped,
        "status": status,
        "image": image,
        "active": active,
        "step": step,
        "insurance_name": insuranceName,
        "insurance": insurance,
        "question_number": questionNumber,
      };
}
