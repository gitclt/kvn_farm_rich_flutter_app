// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';

UserUpdateModel userUpdateModelFromJson(String str) => UserUpdateModel.fromJson(json.decode(str));

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
    bool status;
    String message;
   EditProfile data;

    UserUpdateModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
        status: json["status"],
        message: json["message"],
        data: EditProfile.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class EditProfile{
    // int id;
    // String name;
    // String code;
    // String password;
    // String mobile;
    // String email;
    // String state;
    // String location;
    // int designationId;
    // DateTime dob;
    // DateTime doj;
    // String address;
    // dynamic businessheadId;
    // dynamic zsmId;
    // dynamic salescordinatorId;
    // DateTime addedon;
    // int activestatus;
    // int roleId;
    // int blockStatus;
    // String branchId;
    // DateTime lastLogin;
    // String appVersion;
    // int deleteStatus;
    // dynamic deletedOn;
    // dynamic deletedBy;
    // dynamic deletedType;

   EditProfile(
    // {
        // required this.id,
        // required this.name,
        // required this.code,
        // required this.password,
        // required this.mobile,
        // required this.email,
        // required this.state,
        // required this.location,
        // required this.designationId,
        // required this.dob,
        // required this.doj,
        // required this.address,
        // required this.businessheadId,
        // required this.zsmId,
        // required this.salescordinatorId,
        // required this.addedon,
        // required this.activestatus,
        // required this.roleId,
        // required this.blockStatus,
        // required this.branchId,
        // required this.lastLogin,
        // required this.appVersion,
        // required this.deleteStatus,
        // required this.deletedOn,
        // required this.deletedBy,
        // required this.deletedType,
    // }
    );

    factory EditProfile.fromJson(Map<String, dynamic> json) => EditProfile(
        // id: json["id"],
        // name: json["name"],
        // code: json["code"],
        // password: json["password"],
        // mobile: json["mobile"],
        // email: json["email"],
        // state: json["state"],
        // location: json["location"],
        // designationId: json["designation_id"],
        // dob: DateTime.parse(json["dob"]),
        // doj: DateTime.parse(json["doj"]),
        // address: json["address"],
        // businessheadId: json["businesshead_id"],
        // zsmId: json["zsm_id"],
        // salescordinatorId: json["salescordinator_id"],
        // addedon: DateTime.parse(json["addedon"]),
        // activestatus: json["activestatus"],
        // roleId: json["role_id"],
        // blockStatus: json["block_status"],
        // branchId: json["branch_id"],
        // lastLogin: DateTime.parse(json["last_login"]),
        // appVersion: json["app_version"],
        // deleteStatus: json["delete_status"],
        // deletedOn: json["deleted_on"],
        // deletedBy: json["deleted_by"],
        // deletedType: json["deleted_type"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        // "name": name,
        // "code": code,
        // "password": password,
        // "mobile": mobile,
        // "email": email,
        // "state": state,
        // "location": location,
        // "designation_id": designationId,
        // "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        // "doj": "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
        // "address": address,
        // "businesshead_id": businessheadId,
        // "zsm_id": zsmId,
        // "salescordinator_id": salescordinatorId,
        // "addedon": "${addedon.year.toString().padLeft(4, '0')}-${addedon.month.toString().padLeft(2, '0')}-${addedon.day.toString().padLeft(2, '0')}",
        // "activestatus": activestatus,
        // "role_id": roleId,
        // "block_status": blockStatus,
        // "branch_id": branchId,
        // "last_login": lastLogin.toIso8601String(),
        // "app_version": appVersion,
        // "delete_status": deleteStatus,
        // "deleted_on": deletedOn,
        // "deleted_by": deletedBy,
        // "deleted_type": deletedType,
    };
}
