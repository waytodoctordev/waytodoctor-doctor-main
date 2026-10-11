// To parse this JSON data, do
//
//     final doctorLogin = doctorLoginFromJson(jsonString);

import 'dart:convert';

AuthModel? doctorLoginFromJson(String str) =>
    AuthModel.fromJson(json.decode(str));

String doctorLoginToJson(AuthModel? data) => json.encode(data!.toJson());

class AuthModel {
  AuthModel({
    this.status,
    this.code,
    this.msg,
    this.authData,
  });

  bool? status;
  int? code;
  String? msg;
  AuthData? authData;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        authData: json['data'] != null ? AuthData.fromJson(json["data"]): null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": authData!.toJson(),
      };
}

class AuthData {
  AuthData({
    this.token,
    this.doctor,
    this.firebaseToken,
  });

  String? token;
  String? firebaseToken;
  Doctor? doctor;


  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        token: json["token"],
        firebaseToken: json['firebase_token'],
    doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,

      );

  Map<String, dynamic> toJson() => {
        "token": token,
        'firebase_token':firebaseToken,
        "doctor": doctor!.toJson(),
      };
}

class Doctor {
  Doctor({
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
    this.subscriptionId,
    this.isSubscribed,
    this.pictures,
  });

  int? id;
  int? userId;
  bool? isBlock;
  int? subscriptionId;
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
  bool? isSubscribed;
  String? description;
  String? phone;
  String? step;
  double? lat;
  double? long;
  int? clinicId;
  List<Certificate>? certificates;
  List<Certificate>? studies;
  List<Certificate>? pictures;

  factory Doctor.fromJson(Map<String, dynamic> json) =>
      Doctor(
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
        subscriptionId: json["subscription_id"],
        isSubscribed: json["is_sub"],
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
        "subscriptionId": subscriptionId,
        "is_sub": isSubscribed,
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
