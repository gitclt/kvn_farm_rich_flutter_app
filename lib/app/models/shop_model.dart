import 'dart:convert';

ShopModel leadModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String leadModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  bool status;
  String message;
  ShopDetails data;

  ShopModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        status: json["status"],
        message: json["message"],
        data: ShopDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ShopDetails {
  int id;
  String date;
  String name;
  String contactPerson;
  String mobile;
  String email;
  String state;
  String place;
  String address;
  String pincode;
  int lat;
  int longi;
  String gpsLoc;
  String currentGrade;
  dynamic classification;
  dynamic priority;
  String flag;
  int tse;
  int tsc;
  int zsm;
  int bh;
  int deleteStatus;
  String deletedOn;
  int? createdBy;
  String? createdType;
  String? leadSource;
  String? branchId;
  String? prodCapacity;
  String? cuCode;

  ShopDetails({
    required this.id,
    required this.date,
    required this.name,
    required this.contactPerson,
    required this.mobile,
    required this.email,
    required this.state,
    required this.place,
    required this.address,
    required this.pincode,
    required this.lat,
    required this.longi,
    required this.gpsLoc,
    required this.currentGrade,
    required this.classification,
    required this.priority,
    required this.flag,
    required this.tse,
    required this.tsc,
    required this.zsm,
    required this.bh,
    required this.deleteStatus,
    required this.deletedOn,
    this.createdBy,
    this.createdType,
    this.leadSource,
    this.branchId,
    this.prodCapacity,
    this.cuCode,
  });

  factory ShopDetails.fromJson(Map<String, dynamic> json) => ShopDetails(
        id: json["id"],
        date: json["date"],
        name: json["name"],
        contactPerson: json["contact_person"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        place: json["place"],
        address: json["address"],
        pincode: json["pincode"],
        lat: json["lat"],
        longi: json["longi"],
        gpsLoc: json["gps_loc"],
        currentGrade: json["current_grade"],
        classification: json["classification"],
        priority: json["priority"],
        flag: json["flag"],
        tse: json["tse"],
        tsc: json["tsc"],
        zsm: json["zsm"],
        bh: json["bh"],
        deleteStatus: json["delete_status"],
        deletedOn: json["deleted_on"],
        createdBy: json["created_by"],
        createdType: json["created_type"],
        leadSource: json["lead_source"],
        branchId: json["branch_id"].toString(),
        prodCapacity: json["prod_capacity"],
        cuCode: json["cu_code"],
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
        "delete_status": deleteStatus,
        "deleted_on": deletedOn,
        "created_by": createdBy,
        "created_type": createdType,
        "lead_source": leadSource,
        "branch_id": branchId,
        "prod_capacity": prodCapacity,
        "cu_code": cuCode,
      };
}
