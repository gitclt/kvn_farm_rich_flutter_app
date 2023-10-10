// To parse this JSON data, do
//
//     final attendaceModel = attendaceModelFromJson(jsonString);

import 'dart:convert';

AttendaceModel attendaceModelFromJson(String str) =>
    AttendaceModel.fromJson(json.decode(str));

String attendaceModelToJson(AttendaceModel data) => json.encode(data.toJson());

class AttendaceModel {
  bool status;
  String message;
  List<AttendenceResponse> data;

  AttendaceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendaceModel.fromJson(Map<String, dynamic> json) => AttendaceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AttendenceResponse>.from(
                json["data"].map((x) => AttendenceResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AttendenceResponse {
  int? id;
  String? empId;
  DateTime? checkindate;
  String? checkinLat;
  String? checkinLong;
  String? checkinLoc;
  DateTime? checkoutdate;
  String? checkoutLat;
  String? checkoutLong;
  String? checkoutLoc;
  String? workhour;
  String? photo;
  String? remark;

  AttendenceResponse({
    this.id,
    this.empId,
    this.checkindate,
    this.checkinLat,
    this.checkinLong,
    this.checkinLoc,
    this.checkoutdate,
    this.checkoutLat,
    this.checkoutLong,
    this.checkoutLoc,
    this.workhour,
    this.photo,
    this.remark,
  });

  factory AttendenceResponse.fromJson(Map<String, dynamic> json) =>
      AttendenceResponse(
        id: json["id"],
        empId: json["emp_id"] ?? "",
        checkindate: DateTime.parse(json["checkindate"] ?? ""),
        checkinLat: json["checkin_lat"] ?? "",
        checkinLong: json["checkin_long"] ?? "",
        checkinLoc: json["checkin_loc"] ?? "",
        checkoutdate: json["checkoutdate"] == null
            ? null
            : DateTime.parse(json["checkoutdate"] ?? ""),
        checkoutLat: json["checkout_lat"] ?? "",
        checkoutLong: json["checkout_long"] ?? "",
        checkoutLoc: json["checkout_loc"] ?? "",
        workhour: json["workhour"] ?? "",
        photo: json["photo"] ?? "",
        remark: json["remark"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "checkindate": checkindate!.toIso8601String(),
        "checkin_lat": checkinLat,
        "checkin_long": checkinLong,
        "checkin_loc": checkinLoc,
        "checkoutdate": checkoutdate?.toIso8601String(),
        "checkout_lat": checkoutLat,
        "checkout_long": checkoutLong,
        "checkout_loc": checkoutLoc,
        "workhour": workhour,
        "photo": photo,
        "remark": remark,
      };
}
