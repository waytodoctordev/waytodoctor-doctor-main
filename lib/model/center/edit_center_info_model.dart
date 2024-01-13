import 'category_centers.dart';


class EditCenterInfoModel {
  bool? status;
  int? code;
  String? msg;
  CategoryCentersData? data;

  EditCenterInfoModel({this.status, this.code, this.msg, this.data});

  EditCenterInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ?  CategoryCentersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


