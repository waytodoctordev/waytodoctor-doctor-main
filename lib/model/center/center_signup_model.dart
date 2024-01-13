import 'dart:convert';

// CenterLoginModel? centerLoginModelFromJson(String str) => CenterLoginModel.fromJson(json.decode(str));
//
// String centerLoginModelToJson(CenterLoginModel? data) => json.encode(data!.toJson());

class CenterLoginModel {
  bool status;
  int code;
  String msg;
  CenterLoginModelData data;

  CenterLoginModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CenterLoginModel.fromJson(Map<String, dynamic> json) => CenterLoginModel(
    status: json["status"],
    code: json["code"],
    msg: json["msg"],
    data: CenterLoginModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
    "data": data.toJson(),
  };
}

class CenterLoginModelData {
  String token;
  CenterLoginData data;

  CenterLoginModelData({
    required this.token,
    required this.data,
  });

  factory CenterLoginModelData.fromJson(Map<String, dynamic> json) => CenterLoginModelData(
    token: json["token"],
    data: CenterLoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class CenterLoginData {
  int id;
  String name;
  String address;
  String phoneNumber;
  String image;

  CenterLoginData({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.image,
  });

  factory CenterLoginData.fromJson(Map<String, dynamic> json) =>  CenterLoginData(
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
