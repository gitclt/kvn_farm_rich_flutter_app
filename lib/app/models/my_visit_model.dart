// To parse this JSON data, do
//
//     final visitResponse = visitResponseFromJson(jsonString);

import 'dart:convert';

VisitResponse visitResponseFromJson(String str) =>
    VisitResponse.fromJson(json.decode(str));

String visitResponseToJson(VisitResponse data) => json.encode(data.toJson());

class VisitResponse {
  bool status;
  List<Date> response;

  VisitResponse({
    required this.status,
    required this.response,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) => VisitResponse(
        status: json["status"],
        response: json["data"] == null
            ? []
            : List<Date>.from(json["data"].map((x) => Date.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Date {
  int id;
  DateTime date;
  int empid;
  int leadid;
  String? visitLat;
  String? visitLongi;
  String? visitLoc;
  String? kmDiff;
  String type;
  String? remark;
  String? tour;
  String? credit;
  String? lead;
  String? gpslocation;
  String? place;
  String? lat;
  String? longi;
  String? mobile;
  String? checkoutDate;
  String? visitType;

  Date({
    required this.id,
    required this.date,
    required this.empid,
    required this.leadid,
    this.visitLat,
    this.visitLongi,
    this.visitLoc,
    this.kmDiff,
    required this.type,
    this.remark,
    this.tour,
    this.credit,
    this.lead,
    this.gpslocation,
    this.place,
    required this.lat,
    required this.longi,
    this.mobile,
    this.checkoutDate,
    this.visitType,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        empid: json["empid"],
        leadid: json["leadid"],
        visitLat: json["visit_lat"],
        visitLongi: json["visit_longi"],
        visitLoc: json["visit_loc"],
        kmDiff: json["km_diff"],
        type: json["type"] ?? "",
        remark: json["remark"] ?? "",
        tour: json["tour"].toString(),
        credit: json["credit"].toString(),
        lead: json["lead"] ?? "",
        gpslocation: json["gpslocation"] ?? "",
        place: json["place"] ?? "",
        lat: json["lat"] == null ? '0' : json["lat"]!.toString(),
        longi: json["longi"] == null ? '0' : json["longi"]!.toString(),
        mobile: json["mobile"] ?? "",
        checkoutDate: json["checkout_date"] ?? "",
        visitType: json["visit_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "empid": empid,
        "leadid": leadid,
        "visit_lat": visitLat,
        "visit_longi": visitLongi,
        "visit_loc": visitLoc,
        "km_diff": kmDiff,
        "type": type,
        "remark": remark,
        "tour": tour,
        "credit": credit,
        "lead": lead,
        "gpslocation": gpslocation,
        "place": place,
        "lat": lat,
        "longi": longi,
        "mobile": mobile,
        "checkout_date": checkoutDate,
        "visit_type": visitType,
      };
}
