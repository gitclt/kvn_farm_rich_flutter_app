// To parse this JSON data, do
//
//     final assignRouteResponse = assignRouteResponseFromJson(jsonString);

import 'dart:convert';

AssignRouteResponse assignRouteResponseFromJson(String str) =>
    AssignRouteResponse.fromJson(json.decode(str));

String assignRouteResponseToJson(AssignRouteResponse data) =>
    json.encode(data.toJson());

class AssignRouteResponse {
  bool status;
  String message;
  List<GetRouteDetails> data;

  AssignRouteResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignRouteResponse.fromJson(Map<String, dynamic> json) =>
      AssignRouteResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetRouteDetails>.from(
            json["data"].map((x) => GetRouteDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetRouteDetails {
  String date;
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
  String? offlinecheckin;
  String? offlinecheckout;

  GetRouteDetails({
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
    required this.offlinecheckin,
    required this.offlinecheckout,
  });

  factory GetRouteDetails.fromJson(Map<String, dynamic> json) =>
      GetRouteDetails(
          date: json["date"],
          visitstatus: json["visitstatus"],
          visitType: json["visit_type"],
          empId: json["emp_id"],
          leadId: json["lead_id"],
          leadname: json["leadname"],
          place: json["place"] ?? '',
          flag: json["flag"],
          mobile: json["mobile"],
          lat: json["lat"] == null ? '0.0' : json["lat"]!.toString(),
          longi: json["longi"] == null ? '0.0' : json["longi"]!.toString(),
          gpsLoc: json["gps_loc"] == null ? '0' : json['gps_loc']!.toString(),
          offlinecheckin: json["offlinecheckin"],
          offlinecheckout: json["offlinecheckout"]);

  Map<String, dynamic> toJson() => {
        "date": date,
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
        "offlinecheckin": offlinecheckin,
        "offlinecheckout": offlinecheckout
      };
}
