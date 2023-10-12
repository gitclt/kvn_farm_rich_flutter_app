import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool status;
  String message;
  List<StateDetails> data;

  StateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        message: json["message"],
        data: List<StateDetails>.from(
            json["data"].map((x) => StateDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StateDetails {
  int id;
  String name;
  String country;

  StateDetails({
    required this.id,
    required this.name,
    required this.country,
  });

  factory StateDetails.fromJson(Map<String, dynamic> json) => StateDetails(
        id: json["id"],
        name: json["name"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
      };
}
