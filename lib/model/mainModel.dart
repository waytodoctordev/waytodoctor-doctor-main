class MainModel<T> {
  bool status;
  int code;
  String msg;
  T? data;

  MainModel({
    required this.status,
    required this.code,
    required this.msg,
    this.data,
  });

  // Factory method to create an instance from JSON
  factory MainModel.fromJson(Map<String, dynamic> json,){ //T Function(dynamic) create

    return MainModel(
      status: json['status'] as bool,
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: json['data'],
    );
  }

  // Convert the instance to JSON (useful for sending data)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'msg': msg,
      'data': data,
    };
  }
}
