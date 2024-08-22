import 'dart:convert';

PurchasesModel subscriptionModelFromJson(String str) =>
    PurchasesModel.fromJson(json.decode(str));

String subscriptionModelToJson(PurchasesModel data) =>
    json.encode(data.toJson());

class PurchasesModel {
  PurchasesModel({
    required this.status,
    required this.data,
    required this.code,
    required this.msg,
  });

  final String status;
  final int code;
  final String msg;
  final List<PurchasesDataModel> data;

  factory PurchasesModel.fromJson(Map<String, dynamic> json) {
    return PurchasesModel(
      status: json["status"],
      data: json["data"],
      msg: json["msg"],
      code: json["code"],
    );
  }
  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

class PurchasesDataModel {
  PurchasesDataModel({
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.planId,
    required this.orderNumber,
  });

  final String? startDate;
  final String? endDate;
  final int? userId;
  final int? orderNumber;
  final int? planId;

  factory PurchasesDataModel.fromJson(Map<String, dynamic> json) {
    return PurchasesDataModel(
      startDate: json["start_date"],
      endDate: json["end_date"],
      userId: json["user_id"],
      planId: json["plan_Id"],
      orderNumber: json["order_number"],
    );
  }
  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "plan_Id": planId,
        "user_id": userId,
        "end_date": endDate,
        "order_number": orderNumber,
      };
}
