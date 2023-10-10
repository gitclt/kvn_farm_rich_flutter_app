// To parse this JSON data, do
//
//     final versionResponse = versionResponseFromJson(jsonString);

import 'dart:convert';

List<VersionResponse> versionResponseFromJson(String str) =>
    List<VersionResponse>.from(
        json.decode(str).map((x) => VersionResponse.fromJson(x)));

String versionResponseToJson(List<VersionResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VersionResponse {
  int id;
  String versionName;
  String versioCode;
  DateTime addedOn;

  VersionResponse({
    required this.id,
    required this.versionName,
    required this.versioCode,
    required this.addedOn,
  });

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      VersionResponse(
        id: json["id"],
        versionName: json["version_name"],
        versioCode: json["versio_code"],
        addedOn: DateTime.parse(json["added_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version_name": versionName,
        "versio_code": versioCode,
        "added_on": addedOn.toIso8601String(),
      };
}
