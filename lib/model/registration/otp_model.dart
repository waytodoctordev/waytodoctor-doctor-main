class OtpModel {
  OtpModel({
    this.status,
    this.code,
    this.msg,
  });

  OtpModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
  bool? status;
  int? code;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    return map;
  }
}
