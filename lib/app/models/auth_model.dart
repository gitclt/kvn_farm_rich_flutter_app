import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  bool status;
  String message;
  AuthData data;

  AuthModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        message: json["message"],
        data: AuthData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

class AuthData {
  int id;
  String? name;
  String code;
  String password;
  String mobile;
  String email;
  String state;
  String location;
  String roleName;
  int designationId;
  DateTime dob;
  DateTime doj;
  String address;
  dynamic businessheadId;
  dynamic zsmId;
  dynamic salescordinatorId;
  int activestatus;
  int roleId;
  int blockStatus;
  String branchId;
  dynamic lastLogin;

  AuthData(
      {required this.id,
      this.name,
      required this.code,
      required this.password,
      required this.mobile,
      required this.email,
      required this.state,
      required this.location,
      required this.designationId,
      required this.dob,
      required this.doj,
      required this.address,
      required this.businessheadId,
      required this.zsmId,
      required this.salescordinatorId,
      required this.activestatus,
      required this.roleId,
      required this.blockStatus,
      required this.branchId,
      required this.lastLogin,
      required this.roleName});

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        id: json["employeeId"],
        name: json["employeeName"],
        code: json["code"],
        password: json["password"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        location: json["location"],
        designationId: json["designation_id"],
        dob: DateTime.parse(json["dob"]),
        doj: DateTime.parse(json["doj"]),
        address: json["address"],
        businessheadId: json["businesshead_id"],
        zsmId: json["zsm_id"],
        roleName: json['rolename'] ?? '',
        salescordinatorId: json["salescordinator_id"],
        activestatus: json["activestatus"],
        roleId: json["role_id"],
        blockStatus: json["block_status"],
        branchId: json["branch_id"],
        lastLogin: json["last_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "password": password,
        "mobile": mobile,
        "email": email,
        "state": state,
        "location": location,
        "designation_id": designationId,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "doj":
            "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
        "address": address,
        "businesshead_id": businessheadId,
        "zsm_id": zsmId,
        "salescordinator_id": salescordinatorId,
        "activestatus": activestatus,
        "role_id": roleId,
        "block_status": blockStatus,
        "branch_id": branchId,
        "last_login": lastLogin,
      };
}
