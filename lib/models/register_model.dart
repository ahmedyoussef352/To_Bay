class RegisterModel {
  String? token;
  User? user;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJson(json['user']);
  }
}

class User {
  String? name;
  String? phone;
  String? userCode;
  dynamic id;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    userCode = json['user_code'];
    id = json['id'];
  }
}
