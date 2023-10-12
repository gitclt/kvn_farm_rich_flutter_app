// To parse this JSON data, do
//
//     final markVisitTypesModel = markVisitTypesModelFromJson(jsonString);

import 'dart:convert';

MarkVisitTypesModel markVisitTypesModelFromJson(String str) =>
    MarkVisitTypesModel.fromJson(json.decode(str));

String markVisitTypesModelToJson(MarkVisitTypesModel data) =>
    json.encode(data.toJson());

class MarkVisitTypesModel {
  bool status;
  String message;
  List<MarkVisitTypes> data;

  MarkVisitTypesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MarkVisitTypesModel.fromJson(Map<String, dynamic> json) =>
      MarkVisitTypesModel(
        status: json["status"],
        message: json["message"],
        data: List<MarkVisitTypes>.from(
            json["data"].map((x) => MarkVisitTypes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarkVisitTypes {
  int id;
  String name;

  MarkVisitTypes({
    required this.id,
    required this.name,
  });

  factory MarkVisitTypes.fromJson(Map<String, dynamic> json) => MarkVisitTypes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
