// To parse this JSON data, do
//
//     final doctorDetailsModel = doctorDetailsModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailsModel doctorDetailsModelFromJson(String str) =>
    DoctorDetailsModel.fromJson(json.decode(str));

String doctorDetailsModelToJson(DoctorDetailsModel data) =>
    json.encode(data.toJson());

class DoctorDetailsModel {
  DoctorDetailsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  DoctorDetails? data;

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: DoctorDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class DoctorDetails {
  DoctorDetails({
    this.id,
    this.name,
    this.image,
    this.address,
    this.isfavourie,
    this.categoryId,
    this.categoryName,
    this.userCount,
    this.rating,
    this.experience,
    this.description,
    this.phone,
    this.lat,
    this.long,
    this.clinicId,
    this.payments,
    this.certificates,
    this.studies,
    this.pictures,
  });

  int? id;
  String? name;
  String? image;
  String? address;
  bool? isfavourie;
  int? categoryId;
  String? categoryName;
  int? userCount;
  double? rating;
  int? experience;
  String? description;
  String? phone;
  double? lat;
  double? long;
  int? clinicId;
  List<Certificate>? certificates;
  List<Certificate>? studies;
  List<Certificate>? pictures;
  List<Payment>? payments;

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        address: json["address"],
        isfavourie: json["is_favorite"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        userCount: json["user_count"],
        rating: json["rating"].toDouble(),
        experience: json["experience"],
        description: json["description"],
        phone: json["phone"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
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
        "name": name,
        "image": image,
        "address": address,
        "category_id": categoryId,
        "is_favorite": isfavourie,
        "category_name": categoryName,
        "user_count": userCount,
        "rating": rating,
        "experience": experience,
        "description": description,
        "phone": phone,
        "lat": lat,
        "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
        "long": long,
        "clinic_id": clinicId,
        "certificates":
            List<dynamic>.from(certificates!.map((x) => x.toJson())),
        "studies": List<Studies>.from(studies!.map((x) => x.toJson())),
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

class Studies {
  Studies({
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

  factory Studies.fromJson(Map<String, dynamic> json) => Studies(
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

class Payment {
  Payment({
    required this.id,
    required this.name,
    required this.doctorId,
  });

  int id;
  String name;
  int doctorId;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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
