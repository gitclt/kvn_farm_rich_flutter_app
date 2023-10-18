import 'dart:convert';

GetShopListModel getLeadListModelFromJson(String str) =>
    GetShopListModel.fromJson(json.decode(str));

String getLeadListModelToJson(GetShopListModel data) =>
    json.encode(data.toJson());

class GetShopListModel {
  bool status;
  String message;
  List<GetShopDetails> data;

  GetShopListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetShopListModel.fromJson(Map<String, dynamic> json) =>
      GetShopListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetShopDetails>.from(
                json["data"].map((x) => GetShopDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetShopDetails {
  int id;
  String date;
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
  String currentGrade;
  String? classification;
  String? priority;
  String flag;
  int tse;
  int? tsc;
  int zsm;
  int bh;
  String? code;
  // int deleteStatus;
  // String deletedOn;

  GetShopDetails(
      {required this.id,
      required this.date,
      required this.name,
      required this.contactPerson,
      required this.mobile,
      required this.email,
      required this.state,
      this.place,
      required this.address,
      required this.pincode,
      required this.lat,
      required this.longi,
      this.gpsLoc,
      required this.currentGrade,
      this.classification,
      this.priority,
      required this.flag,
      required this.tse,
      this.tsc,
      required this.zsm,
      required this.bh,
      this.code
      // required this.deleteStatus,
      // required this.deletedOn,
      });

  factory GetShopDetails.fromJson(Map<String, dynamic> json) => GetShopDetails(
        id: json["id"],
        date: json["date"],
        name: json["name"] ?? "",
        contactPerson: json["contact_person"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        place: json["place"] == null ? "" : json["place"].toString(),
        address: json["address"],
        pincode: json["pincode"],
        lat: json["lat"] == null ? "" : json["lat"].toString(),
        longi: json["longi"] == null ? "" : json["longi"].toString(),
        gpsLoc: json["gps_loc"] ?? "",
        currentGrade: json["current_grade"],
        classification: json["classification"] ?? "",
        priority: json["priority"] ?? "",
        flag: json["flag"],
        tse: json["tse"],
        tsc: json["tsc"] ?? 0,
        zsm: json["zsm"],
        bh: json["bh"],
        code: json["cu_code"] == null ? "" : json["cu_code"].toString(),
        // deleteStatus: json["delete_status"],
        // deletedOn: json["deleted_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
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
        "current_grade": currentGrade,
        "classification": classification,
        "priority": priority,
        "flag": flag,
        "tse": tse,
        "tsc": tsc,
        "zsm": zsm,
        "bh": bh,
        "cu_code": code
        // "delete_status": deleteStatus,
        // "deleted_on": deletedOn,
      };
}
