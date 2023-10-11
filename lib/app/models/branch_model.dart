// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) =>
    BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  bool status;
  String message;
  List<BranchResponse> data;

  BranchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        status: json["status"],
        message: json["message"],
        data: List<BranchResponse>.from(
            json["data"].map((x) => BranchResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BranchResponse {
  int id;
  String name;
  int stateId;

  BranchResponse({
    required this.id,
    required this.name,
    required this.stateId,
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) => BranchResponse(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
