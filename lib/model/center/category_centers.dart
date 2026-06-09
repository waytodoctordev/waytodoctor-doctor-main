class CategoryCenters {
  bool? status;
  int? code;
  String? msg;
  List<CategoryCentersData>? data;

  CategoryCenters({this.status, this.code, this.msg, this.data});

  CategoryCenters.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoryCentersData>[];
      json['data'].forEach((v) {
        data!.add( CategoryCentersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryCentersData {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? image;
  String? centerCategoryId;
  String? showAppointment;
  String? subscriptionId;
  int? userId;
  bool? isSub;


  CategoryCentersData(
      {this.id,
        this.name,
        this.address,
        this.phoneNumber,
        this.image,
        this.centerCategoryId,
        this.showAppointment,
        this.subscriptionId,
        this.userId,
        this.isSub,});

  CategoryCentersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    centerCategoryId = json['center_category_id'];
    showAppointment = json['show_appointment'];
    subscriptionId = json['subscription_id'];
    userId = json['user_id'];
    isSub = json['is_sub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['image'] = image;
    data['center_category_id'] = centerCategoryId;
    data['show_appointment'] = showAppointment;
    data['subscription_id'] = subscriptionId;
    data['user_id'] = userId;
    data['is_sub'] = isSub;
    return data;
  }
}