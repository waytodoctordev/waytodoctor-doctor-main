class MainModel {
  bool? status;
  int? code;
  String? msg;

  MainModel({this.status, this.code, this.msg, });

  MainModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];

  }

}