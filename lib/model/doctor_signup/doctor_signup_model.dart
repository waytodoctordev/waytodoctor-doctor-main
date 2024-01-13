// To parse this JSON data, do
//
//     final doctorSignUpModel = doctorSignUpModelFromJson(jsonString);

import 'dart:convert';

DoctorSignUpModel? doctorSignUpModelFromJson(String str) => DoctorSignUpModel.fromJson(json.decode(str));

String doctorSignUpModelToJson(DoctorSignUpModel? data) => json.encode(data!.toJson());

class DoctorSignUpModel {
  DoctorSignUpModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  DoctorSignUpData? data;

  factory DoctorSignUpModel.fromJson(Map<String, dynamic> json) => DoctorSignUpModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: DoctorSignUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class DoctorSignUpData {
  DoctorSignUpData({
    this.token,
    this.userDoctor,
  });

  String? token;
  UserDoctor? userDoctor;

  factory DoctorSignUpData.fromJson(Map<String, dynamic> json) => DoctorSignUpData(
        token: json["token"],
        userDoctor: UserDoctor.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": userDoctor!.toJson(),
      };
}

class UserDoctor {
  UserDoctor({
    this.id,
    this.name,
    this.email,
    this.userId,
    this.phone,
    this.image,
    this.address,
    this.categoryId,
    this.categoryName,
    this.userCount,
    this.rating,
    this.experience,
    this.description,
    this.lat,
    this.long,
    this.clinicId,
    this.step,
    this.clinicUserId,
    this.certificates,
    this.studies,
    this.pictures,
  });

  int? id;
  String? name;
  String? email;
  int? userId;
  String? phone;
  String? image;
  String? address;
  int? categoryId;
  int? clinicUserId;

  String? categoryName;
  int? userCount;
  double? rating;
  int? experience;
  String? description;
  double? lat;
  double? long;
  int? clinicId;
  String? step;
  List<dynamic>? certificates;
  List<dynamic>? studies;
  List<dynamic>? pictures;

  factory UserDoctor.fromJson(Map<String, dynamic> json) => UserDoctor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userId: json["user_id"],
        phone: json["phone"],
        image: json["image"],
        clinicUserId: json["clinic_user_id"],
        address: json["address"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        userCount: json["user_count"],
        rating: json["rating"].toDouble(),
        experience: json["experience"],
        description: json["description"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        clinicId: json["clinic_id"],
        step: json["step"],
        certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
        studies: json["studies"] == null ? [] : List<dynamic>.from(json["studies"]!.map((x) => x)),
        pictures: json["pictures"] == null ? [] : List<dynamic>.from(json["pictures"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "user_id": userId,
        "clinic_user_id": clinicUserId,
        "phone": phone,
        "image": image,
        "address": address,
        "category_id": categoryId,
        "category_name": categoryName,
        "user_count": userCount,
        "rating": rating,
        "experience": experience,
        "description": description,
        "lat": lat,
        "long": long,
        "clinic_id": clinicId,
        "step": step,
        "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
        "studies": studies == null ? [] : List<dynamic>.from(studies!.map((x) => x)),
        "pictures": pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x)),
      };
}
