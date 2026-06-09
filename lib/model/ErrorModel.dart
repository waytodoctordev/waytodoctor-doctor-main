class ErrorModel {
  ErrorModel({
    required this.status,
    required this.code,
    required this.msg,

  });
  late final bool status;
  late final int code;
  late final String msg;


  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }
}
