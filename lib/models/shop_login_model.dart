class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  // نضع اسماء المتغيرات كماهي في قاعدة البيانات  json['data']
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.id,
    this.credit,
    this.points,
    this.token,
  });

  //named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    credit = json['credit'];
    points = json['points'];
    token = json['token'];
  }
}
