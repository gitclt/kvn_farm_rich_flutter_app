// To parse this JSON data, do
//
//     final assignedRouteListResponse = assignedRouteListResponseFromJson(jsonString);

import 'dart:convert';

AssignedRouteListResponse assignedRouteListResponseFromJson(String str) =>
    AssignedRouteListResponse.fromJson(json.decode(str));

class AssignedRouteListResponse {
  bool status;
  String message;
  List<RouteDatum>? routeData;

  AssignedRouteListResponse({
    required this.status,
    required this.message,
    this.routeData,
  });

  factory AssignedRouteListResponse.fromJson(Map<String, dynamic> json) =>
      AssignedRouteListResponse(
        status: json["status"],
        message: json["message"],
        routeData: json["data"] == null
            ? []
            : List<RouteDatum>.from(
                json["data"].map((x) => RouteDatum.fromJson(x))),
      );
}

class RouteDatum {
  DateTime date;
  int visitstatus;
  String visitType;
  int empId;
  int leadId;
  String leadname;
  String? place;
  String flag;
  String mobile;
  String? lat;
  String? longi;
  String? gpsLoc;

  RouteDatum({
    required this.date,
    required this.visitstatus,
    required this.visitType,
    required this.empId,
    required this.leadId,
    required this.leadname,
    required this.place,
    required this.flag,
    required this.mobile,
    required this.lat,
    required this.longi,
    required this.gpsLoc,
  });

  factory RouteDatum.fromJson(Map<String, dynamic> json) => RouteDatum(
        date: DateTime.parse(json["date"]),
        visitstatus: json["visitstatus"],
        visitType: json["visit_type"] ?? "",
        empId: json["emp_id"],
        leadId: json["lead_id"],
        leadname: json["leadname"],
        place: json["place"] ?? '',
        flag: json["flag"],
        mobile: json["mobile"],
        lat: json["lat"] == null ? '0' : json["lat"]!.toString(),
        longi: json["longi"] == null ? '0' : json["longi"]!.toString(),
        gpsLoc: json["gps_loc"] == null ? '0' : json['gps_loc']!.toString(),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "visitstatus": visitstatus,
        "visit_type": visitType,
        "emp_id": empId,
        "lead_id": leadId,
        "leadname": leadname,
        "place": place,
        "flag": flag,
        "mobile": mobile,
        "lat": lat,
        "longi": longi,
        "gps_loc": gpsLoc,
      };
}
