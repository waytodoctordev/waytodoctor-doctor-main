import 'dart:convert';

CenterModel CenterModelFromJson(String str) =>
    CenterModel.fromJson(json.decode(str));

String CenterModelToJson(CenterModel data) => json.encode(data.toJson());

class CenterModel {
  bool status;
  int code;
  String msg;
  List<Centers> data;

  CenterModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) => CenterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<Centers>.from(json["data"].map((x) => Centers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Centers {
  int id;
  String name;
  String address;
  String phoneNumber;
  String image;

  Centers({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.image,
  });

  factory Centers.fromJson(Map<String, dynamic> json) => Centers(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phoneNumber: json["phone_number"],
    image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone_number": phoneNumber,
    "image": image,
      };
}
