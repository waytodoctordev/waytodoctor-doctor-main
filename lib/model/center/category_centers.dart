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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
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
  int? subscriptionId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['center_category_id'] = this.centerCategoryId;
    data['show_appointment'] = this.showAppointment;
    data['subscription_id'] = this.subscriptionId;
    data['user_id'] = this.userId;
    data['is_sub'] = this.isSub;
    return data;
  }
}