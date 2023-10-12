// To parse this JSON data, do
//
//     final leadCheckInResponse = leadCheckInResponseFromJson(jsonString);

import 'dart:convert';

ShopCheckInResponse shopCheckInResponseFromJson(String str) =>
    ShopCheckInResponse.fromJson(json.decode(str));

String shopCheckInResponseToJson(ShopCheckInResponse data) =>
    json.encode(data.toJson());

class ShopCheckInResponse {
  bool status;
  String message;
  List<ShopCheckInDetails> data;

  ShopCheckInResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShopCheckInResponse.fromJson(Map<String, dynamic> json) =>
      ShopCheckInResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ShopCheckInDetails>.from(
                json["data"].map((x) => ShopCheckInDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShopCheckInDetails {
  int id;
  String date;
  String empId;
  String leadId;
  String lati;
  String longi;
  String loc;
  String kmDiff;
  String type;
  String remark;
  String tour;
  String? creditvisit;
  String? checkoutLat;
  String? checkoutLong;
  String? checkoutLoc;
  String? workhour;
  String? checkoutDate;

  ShopCheckInDetails({
    required this.id,
    required this.date,
    required this.empId,
    required this.leadId,
    required this.lati,
    required this.longi,
    required this.loc,
    required this.kmDiff,
    required this.type,
    required this.remark,
    required this.tour,
    this.creditvisit,
    this.checkoutLat,
    this.checkoutLong,
    this.checkoutLoc,
    this.workhour,
    this.checkoutDate,
  });

  factory ShopCheckInDetails.fromJson(Map<String, dynamic> json) =>
      ShopCheckInDetails(
        id: json["id"],
        date: json["date"] ?? "",
        empId: json["empid"].toString(),
        leadId: json["leadid"].toString(),
        lati: json["lati"] ?? "",
        longi: json["longi"] ?? "",
        loc: json["loc"] ?? "",
        kmDiff: json["km_diff"] ?? "",
        type: json["type"] ?? "",
        remark: json["remark"] ?? "",
        tour: json["tour"].toString(),
        creditvisit: json["creditvisit"].toString(),
        checkoutLat: json["checkout_lat"] ?? "",
        checkoutLong: json["checkout_long"] ?? "",
        checkoutLoc: json["checkout_loc"] ?? "",
        workhour: json["workhour"] ?? "",
        checkoutDate: json["checkout_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "emp_id": empId,
        "lead_id": leadId,
        "lati": lati,
        "longi": longi,
        "loc": loc,
        "km_diff": kmDiff,
        "type": type,
        "remark": remark,
        "tour": tour,
        "creditvisit": creditvisit,
        "checkout_lat": checkoutLat,
        "checkout_long": checkoutLong,
        "checkout_loc": checkoutLoc,
        "workhour": workhour,
        "checkout_date": checkoutDate,
      };
}
