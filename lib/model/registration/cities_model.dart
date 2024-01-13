// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.status,
    this.code,
    this.msg,
    this.cities,
  });

  bool? status;
  int? code;
  String? msg;
  List<City>? cities;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        cities: List<City>.from(json["data"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.name,
    this.code,
  });

  int? id;
  String? name;
  String? code;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
