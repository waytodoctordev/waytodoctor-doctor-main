// To parse this JSON data, do
//
//     final doctorLogin = doctorLoginFromJson(jsonString);

import 'dart:convert';

DoctorLoginModel? doctorLoginFromJson(String str) =>
    DoctorLoginModel.fromJson(json.decode(str));

String doctorLoginToJson(DoctorLoginModel? data) => json.encode(data!.toJson());

class DoctorLoginModel {
  DoctorLoginModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  LoginData? data;

  factory DoctorLoginModel.fromJson(Map<String, dynamic> json) =>
      DoctorLoginModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class LoginData {
  LoginData({
    this.token,
    this.doctorLogindata,
  });

  String? token;
  DoctorLoginData? doctorLogindata;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        doctorLogindata: DoctorLoginData.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "doctor": doctorLogindata!.toJson(),
      };
}

class DoctorLoginData {
  DoctorLoginData({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.address,
    this.email,
    this.categoryId,
    this.categoryName,
    this.userCount,
    this.rating,
    this.experience,
    this.description,
    this.phone,
    this.lat,
    this.long,
    this.step,
    this.clinicUserId,
    this.clinicId,
    this.certificates,
    this.studies,
    this.isBlock,
    // this.subscriptionId,
    // this.isSubscriped,
    this.pictures,
  });

  int? id;
  int? userId;
  bool? isBlock;
  // int? subscriptionId;
  String? name;
  String? image;
  String? address;
  String? email;
  int? clinicUserId;
  int? categoryId;
  String? categoryName;
  int? userCount;
  double? rating;
  int? experience;
  // int? isSubscriped;
  String? description;
  String? phone;
  String? step;
  double? lat;
  double? long;
  int? clinicId;
  List<Certificate>? certificates;
  List<Certificate>? studies;
  List<Certificate>? pictures;

  factory DoctorLoginData.fromJson(Map<String, dynamic> json) =>
      DoctorLoginData(
        id: json["id"],
        isBlock: json["block"],
        name: json["name"],
        step: json["step"],
        clinicUserId: json["clinic_user_id"],
        userId: json["user_id"],
        image: json["image"],
        address: json["address"],
        email: json["email"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        userCount: json["user_count"],
        rating: json["rating"].toDouble(),
        experience: json["experience"],
        description: json["description"],
        phone: json["phone"],
        // subscriptionId: json["subscriptionId"],
        // isSubscriped: json["isSubscriped"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        clinicId: json["clinic_id"],
        certificates: List<Certificate>.from(
            json["certificates"].map((x) => Certificate.fromJson(x))),
        studies: List<Certificate>.from(
            json["studies"].map((x) => Certificate.fromJson(x))),
        pictures: List<Certificate>.from(
            json["pictures"].map((x) => Certificate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "block": isBlock,
        "user_id": userId,
        "name": name,
        "clinic_name": clinicUserId,
        "step": step,
        "image": image,
        "address": address,
        "category_id": categoryId,
        "email": email,
        "category_name": categoryName,
        "user_count": userCount,
        "rating": rating,
        // "subscriptionId": subscriptionId,
        // "isSubscriped": isSubscriped,
        "experience": experience,
        "description": description,
        "phone": phone,
        "lat": lat,
        "long": long,
        "clinic_id": clinicId,
        "certificates":
            List<dynamic>.from(certificates!.map((x) => x.toJson())),
        "studies": List<dynamic>.from(studies!.map((x) => x.toJson())),
        "pictures": List<dynamic>.from(pictures!.map((x) => x.toJson())),
      };
}

class Certificate {
  Certificate({
    this.id,
    this.title,
    this.image,
    this.file,
    this.doctorId,
  });

  int? id;
  String? title;
  String? image;
  String? file;
  int? doctorId;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        file: json["file"],
        doctorId: json["doctor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "file": file,
        "doctor_id": doctorId,
      };
}
