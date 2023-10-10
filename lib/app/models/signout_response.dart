// To parse this JSON data, do
//
//     final signOutResponse = signOutResponseFromJson(jsonString);

import 'dart:convert';

SignOutResponse signOutResponseFromJson(String str) =>
    SignOutResponse.fromJson(json.decode(str));

String signOutResponseToJson(SignOutResponse data) =>
    json.encode(data.toJson());

class SignOutResponse {
  bool status;
  String message;

  SignOutResponse({
    required this.status,
    required this.message,
  });

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      SignOutResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
