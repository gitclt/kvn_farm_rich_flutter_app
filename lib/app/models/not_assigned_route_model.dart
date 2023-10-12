// To parse this JSON data, do
//
//     final notAssigedRouteListResponse = notAssigedRouteListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

NotAssigedRouteListResponse notAssigedRouteListResponseFromJson(String str) =>
    NotAssigedRouteListResponse.fromJson(json.decode(str));

class NotAssigedRouteListResponse {
  bool status;
  String message;
  List<NotAssignedRoute>? notAssignedRoute;

  NotAssigedRouteListResponse({
    required this.status,
    required this.message,
    this.notAssignedRoute,
  });

  factory NotAssigedRouteListResponse.fromJson(Map<String, dynamic> json) =>
      NotAssigedRouteListResponse(
        status: json["status"],
        message: json["message"],
        notAssignedRoute: json["data"] == null
            ? []
            : List<NotAssignedRoute>.from(
                json["data"].map((x) => NotAssignedRoute.fromJson(x))),
      );
}

class NotAssignedRoute {
  int id;
  DateTime date;
  String name;
  String contactPerson;
  String mobile;
  String email;
  String state;
  String? place;
  String address;
  String pincode;
  String? lat;
  String? longi;
  String? gpsLoc;
  RxBool isSelect;
  RxString? type;

  NotAssignedRoute(
      {required this.id,
      required this.date,
      required this.name,
      required this.contactPerson,
      required this.mobile,
      required this.email,
      required this.state,
      required this.place,
      required this.address,
      required this.pincode,
      this.lat,
      this.longi,
      required this.gpsLoc,
      required this.isSelect,
      this.type});

  factory NotAssignedRoute.fromJson(Map<String, dynamic> json) =>
      NotAssignedRoute(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        contactPerson: json["contact_person"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        place: json["place"],
        address: json["address"],
        pincode: json["pincode"],
        lat: json["lat"] == null ? '0.0' : json["lat"]!.toString(),
        longi: json["longi"] == null ? '0.0' : json["longi"]!.toString(),
        gpsLoc: json["gps_loc"] == null ? '0' : json['gps_loc']!.toString(),
        isSelect: false.obs,
        type: 'Live'.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "name": name,
        "contact_person": contactPerson,
        "mobile": mobile,
        "email": email,
        "state": state,
        "place": place,
        "address": address,
        "pincode": pincode,
        "lat": lat,
        "longi": longi,
        "gps_loc": gpsLoc,
      };
}
