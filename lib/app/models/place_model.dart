import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool status;
  String message;
  List<LocationDetails> data;

  LocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        status: json["status"],
        message: json["message"],
        data: List<LocationDetails>.from(
            json["data"].map((x) => LocationDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationDetails {
  int id;
  String name;
  int stateId;

  LocationDetails({
    required this.id,
    required this.name,
    required this.stateId,
  });

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      LocationDetails(
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
