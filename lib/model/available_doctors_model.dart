// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

AvailableDoctorsModel availableDoctorsModelFromJson(String str) =>
    AvailableDoctorsModel.fromJson(json.decode(str));

String doctorModelToJson(AvailableDoctorsModel data) =>
    json.encode(data.toJson());

class AvailableDoctorsModel {
  AvailableDoctorsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Doctors>? data;

  factory AvailableDoctorsModel.fromJson(Map<String, dynamic> json) =>
      AvailableDoctorsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json['data'] != null
            ? List<Doctors>.from(json["data"].map((x) => Doctors.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Doctors {
  Doctors({
    this.id,
    this.name,
    this.image,
    this.address,
    this.userId,
    this.isBlocked,
    this.categoryName,
    this.userCount,
    this.rating,
    this.experience,
    this.description,
    this.phone,
    this.lat,
    this.long,
    this.pictures,

    //   this.categoryId,

    // this.clinicId,
    // this.certificates,
    // this.studies,
  });

  int? id;
  String? name;
  String? image;
  String? address;

  String? phone;
  double? lat;
  double? long;

  bool? isBlocked;

  // int? categoryId;
  double? rating;
  String? categoryName;
  int? userId;
  List<Certificate>? pictures;

  int? userCount;

  int? experience;
  String? description;

  //  int? clinicId;
  // List<Certificate>? certificates;
  // List<Certificate>? studies;

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        id: json["id"],
        userId: json["user_id"],
        isBlocked: json["block"],
        name: json["name"],
        image: json["image"],
        address: json["address"],
        // categoryId: json["category_id"],
        categoryName: json["category_name"],
        userCount: json["user_count"],
        rating: json["rating"].toDouble(),
        experience: json["experience"],
        description: json["description"],
        phone: json["phone"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        //  clinicId: json["clinic_id"],
        // certificates: List<Certificate>.from(
        // json["certificates"].map((x) => Certificate.fromJson(x))),
        // studies: List<Certificate>.from(
        // json["studies"].map((x) => Certificate.fromJson(x))),
        pictures: List<Certificate>.from(
            json["pictures"].map((x) => Certificate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "block": isBlocked,
        "name": name,
        "image": image,
        "address": address,
        //  "category_id": categoryId,
        "category_name": categoryName,
        "user_count": userCount,
        "rating": rating,
        "experience": experience,
        "description": description,
        "phone": phone,
        "lat": lat,
        "long": long,
        //  "clinic_id": clinicId,
        // "certificates":
        // List<dynamic>.from(certificates!.map((x) => x.toJson())),
        // "studies": List<dynamic>.from(studies!.map((x) => x.toJson())),
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
