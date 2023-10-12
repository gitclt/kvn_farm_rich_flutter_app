import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  bool status;
  String message;
  List<TeamDetails> data;

  TeamModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        status: json["status"],
        message: json["message"],
        data: List<TeamDetails>.from(
            json["data"].map((x) => TeamDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TeamDetails {
  int id;
  String state;
  String address;
  String roleName;
  String designationName;
  String location;
  String? mobile;
  String? name;

  TeamDetails(
      {required this.id,
      required this.state,
      required this.address,
      required this.roleName,
      required this.designationName,
      required this.location,
      this.mobile,
      this.name,
      r});

  factory TeamDetails.fromJson(Map<String, dynamic> json) => TeamDetails(
        id: json["id"],
        state: json["state"],
        address: json["address"],
        roleName: json["roleName"],
        designationName: json["designationName"],
        location: json["location"],
        mobile: json["mobile"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "address": address,
        "roleName": roleName,
        "designationName": designationName,
        "location": location,
        "mobile": mobile,
        "name": name,
      };
}
