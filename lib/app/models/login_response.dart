// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  bool status;
  String message;
  List<LoginData> data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<LoginData>.from(
                json["data"].map((x) => LoginData.fromJson(x))),
      );
}

class LoginData {
  int id;

  LoginData({
    required this.id,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
