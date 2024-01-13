// To parse this JSON data, do
//
//     final medicalInfoModel = medicalInfoModelFromJson(jsonString);

import 'dart:convert';

MedicalInfoModel medicalInfoModelFromJson(String str) =>
    MedicalInfoModel.fromJson(json.decode(str));

String medicalInfoModelToJson(MedicalInfoModel data) =>
    json.encode(data.toJson());

class MedicalInfoModel {
  MedicalInfoModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  List<MedicalData> data;

  factory MedicalInfoModel.fromJson(Map<String, dynamic> json) =>
      MedicalInfoModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<MedicalData>.from(
            json["data"].map((x) => MedicalData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MedicalData {
  MedicalData({
    required this.id,
    required this.section,
    required this.sectionId,
    required this.question,
    required this.questionDescription,
    required this.questionId,
    this.answer,
    required this.answerId,
  });

  int id;
  String section;
  int sectionId;
  String question;
  String questionDescription;
  int questionId;
  String? answer;
  int answerId;

  factory MedicalData.fromJson(Map<String, dynamic> json) => MedicalData(
        id: json["id"],
        section: json["section"],
        sectionId: json["section_id"],
        question: json["question"],
        questionDescription: json["question_description"],
        questionId: json["question_id"],
        answer: json["answer"],
        answerId: json["answer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section": section,
        "section_id": sectionId,
        "question": question,
        "question_description": questionDescription,
        "question_id": questionId,
        "answer": answer,
        "answer_id": answerId,
      };
}
