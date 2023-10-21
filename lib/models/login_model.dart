// ignore_for_file: non_constant_identifier_names

class LoginModel {
  String? message;
  String? token;
  UserModel? user;
  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json["massage"];
    token = json["token"];
    user = UserModel.fromJson(json["user"]);
  }
}

class UserModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic charge;
  dynamic user_code;
  dynamic status;
  dynamic email_verified_at;
  dynamic created_at;
  dynamic updated_at;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    charge = json["charge"];
    user_code = json["user_code"];
    status = json["status"];
    email_verified_at = json["email_verified_at"];
    created_at = json["created_at"];
    updated_at = json["updated_at"];
  }
}
