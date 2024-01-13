// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  TransactionData data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: TransactionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class TransactionData {
  TransactionData({
    required this.id,
    required this.orderNumber,
    required this.orderAmount,
    required this.orderCurrency,
    required this.orderDescription,
    required this.type,
    required this.status,
    required this.card,
    required this.date,
    required this.hash,
    required this.cardExpirationDate,
    required this.customerName,
    required this.customerEmail,
    required this.customerCountry,
    required this.customerState,
    required this.customerCity,
    required this.customerAddress,
    required this.customerIp,
  });

  String id;
  String orderNumber;
  String orderAmount;
  String orderCurrency;
  String orderDescription;
  String type;
  String status;
  String card;
  DateTime date;
  String hash;
  String cardExpirationDate;
  String customerName;
  String customerEmail;
  String customerCountry;
  String customerState;
  String customerCity;
  String customerAddress;
  String customerIp;

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        id: json["id"],
        orderNumber: json["order_number"],
        orderAmount: json["order_amount"],
        orderCurrency: json["order_currency"],
        orderDescription: json["order_description"],
        type: json["type"],
        status: json["status"],
        card: json["card"],
        date: DateTime.parse(json["date"]),
        hash: json["hash"],
        cardExpirationDate: json["card_expiration_date"] ?? '',
        customerName: json["customer_name"] ?? '',
        customerEmail: json["customer_email"] ?? '',
        customerCountry: json["customer_country"] ?? '',
        customerState: json["customer_state"] ?? '',
        customerCity: json["customer_city"] ?? '',
        customerAddress: json["customer_address"] ?? '',
        customerIp: json["customer_ip"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "order_amount": orderAmount,
        "order_currency": orderCurrency,
        "order_description": orderDescription,
        "type": type,
        "status": status,
        "card": card,
        "date": date.toIso8601String(),
        "hash": hash,
        "card_expiration_date": cardExpirationDate,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_country": customerCountry,
        "customer_state": customerState,
        "customer_city": customerCity,
        "customer_address": customerAddress,
        "customer_ip": customerIp,
      };
}
