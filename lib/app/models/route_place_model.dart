// To parse this JSON data, do
//
//     final routePlaceModel = routePlaceModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

RoutePlaceModel routePlaceModelFromJson(String str) =>
    RoutePlaceModel.fromJson(json.decode(str));

String routePlaceModelToJson(RoutePlaceModel data) =>
    json.encode(data.toJson());

class RoutePlaceModel {
  bool status;
  List<Routes> data;

  RoutePlaceModel({
    required this.status,
    required this.data,
  });

  factory RoutePlaceModel.fromJson(Map<String, dynamic> json) =>
      RoutePlaceModel(
        status: json["status"],
        data: List<Routes>.from(json["data"].map((x) => Routes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Routes {
  Route route;
  List<Place> places;

  Routes({
    required this.route,
    required this.places,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        route: Route.fromJson(json["route"]),
        places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "route": route.toJson(),
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}

class Place {
  String name;
  int id;
  RxBool isSelect;

  Place({
    required this.name,
    required this.id,
    required this.isSelect
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        id: json["id"],
        isSelect: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class Route {
  String routename;

  Route({
    required this.routename,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        routename: json["routename"],
      );

  Map<String, dynamic> toJson() => {
        "routename": routename,
      };
}
