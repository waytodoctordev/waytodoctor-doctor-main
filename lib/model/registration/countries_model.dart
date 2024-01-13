// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'dart:convert';

CountriesModel countriesModelFromJson(String str) =>
    CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
    this.status,
    this.code,
    this.msg,
    this.countries,
  });

  bool? status;
  int? code;
  String? msg;
  List<Country>? countries;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        countries:
            List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.id,
    this.name,
    this.code,
    this.skipOtp,
    this.digits,
    this.image,
  });

  int? id;
  int? digits;
  int? skipOtp;
  String? name;
  String? code;
  String? image;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        skipOtp: json["skip_otp"],
        digits: json["digits"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "digits": digits,
        "skip_otp": skipOtp,
        "code": code,
        "image": image,
      };
}
