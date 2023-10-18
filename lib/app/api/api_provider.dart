import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/api/http_provider.dart';
import 'package:kvn_farm_rich/app/models/api_model.dart';
import 'package:kvn_farm_rich/app/models/assigned_route_list_model.dart';
import 'package:kvn_farm_rich/app/models/assigned_route_model.dart';
import 'package:kvn_farm_rich/app/models/attendance_report_model.dart';
import 'package:kvn_farm_rich/app/models/auth_model.dart';
import 'package:kvn_farm_rich/app/models/branch_model.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/models/location_update_model.dart';
import 'package:kvn_farm_rich/app/models/login_response.dart';
import 'package:kvn_farm_rich/app/models/mark_visit_types_model.dart';
import 'package:kvn_farm_rich/app/models/my_visit_model.dart';
import 'package:kvn_farm_rich/app/models/not_assigned_route_model.dart';
import 'package:kvn_farm_rich/app/models/place_model.dart';
import 'package:kvn_farm_rich/app/models/route_place_model.dart';
import 'package:kvn_farm_rich/app/models/shop_checkin_model.dart';
import 'package:kvn_farm_rich/app/models/shop_model.dart';
import 'package:kvn_farm_rich/app/models/signout_response.dart';
import 'package:kvn_farm_rich/app/models/state_model.dart';
import 'package:kvn_farm_rich/app/models/team_model.dart';
import 'package:kvn_farm_rich/app/models/version_response.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:path/path.dart' as path;

class ApiProvider {
  Future<VersionResponse?> getAppVersion() async {
    var response = await HttpApiConnect().get("appversionmodels");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return VersionResponse.fromJson(json.decode(data).toList()[0]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LoginResponse?> login(
    String username,
    String password,
  ) async {
    var response = await HttpApiConnect()
        .get("Employee/login?mobile=$username&password=$password");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return LoginResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AuthModel?> getProfile(
    String id,
  ) async {
    var add = {
      "empid": id,
    };

    try {
      final response = await http.post(
          Uri.parse('${BaseUrl().baseUrl}Employee/view_profile'),
          body: add);

      if (response.statusCode == 200) {
        var data = response.body;
        return AuthModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      //  serverErrorPop(response.statusCode.toString(),
      // massage(response.statusCode), response.body);
      return null;
    }
  }

  Future<UserUpdateModel?> editProfile({
    required String id,
    String? name,
    String? code,
    String? password,
    String? mobile,
    String? email,
    String? state,
    String? place,
  }) async {
    var add = {
      "id": id,
      "name": name,
      "code": code,
      "password": password,
      "mobile": mobile,
      "email": email,
      "state": state,
      "location": place,
    };
    var response = await HttpApiConnect().post("Employee/Update_profile", add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return UserUpdateModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiModel?> updateUserLoginStatus() async {
    var add = {
      "app_version": AppSettings().appVersionNo.toString(),
      "empid": Session.userId,
    };

    var response = await http.post(
        Uri.parse('${BaseUrl().baseUrl}Employee/lastlog_update'),
        body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ApiModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AttendaceModel?> viewAttendance(String empId) async {
    var add = {
      "empid": empId,
    };
    final response = await http.post(
        Uri.parse('${BaseUrl().baseUrl}Employee/today_attendance'),
        body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return AttendaceModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AttendaceModel?> markSignIn(String empId, String lat, String long,
      String location, String image, File photo) async {
    // var add = {
    //   "empid": empId,
    //   "lat": lat,
    //   "longi": long,
    //   "loc": location,
    //   if (photo != null)
    //     "photo": MultipartFile(
    //       File(photo.path),
    //       filename: image,
    //     )
    // };
    var url = Uri.parse("${BaseUrl().baseUrl}Employee/Signin");

    var request = http.MultipartRequest('POST', url);
    request.fields['empid'] = empId;
    request.fields['lat'] = lat;
    request.fields['longi'] = long;
    request.fields['loc'] = location;
    var fileImage = await http.MultipartFile.fromPath('photo', photo.path,
        filename: path.basename(photo.path),
        contentType: MediaType('image', 'jpg'));
    request.files.add(fileImage);
    var streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return AttendaceModel.fromJson(json.decode(data));
      } else {
        throw Exception(
            'Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }

  Future<SignOutResponse?> markSignOut(String empId, String lat, String long,
      String location, String workHour, String remark) async {
    var add = {
      "empid": empId,
      "lat": lat,
      "longi": long,
      "loc": location,
      "workhour": workHour,
      "remark": remark
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Employee/Signout'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return SignOutResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AttendaceModel?> getAttendence(
    String month,
    String year,
    String id,
  ) async {
    final response = await HttpApiConnect()
        .get('Employee/attendance_view?month=$month&year=$year&empid=$id');
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return AttendaceModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<GetShopListModel?> fetchLeads(
    String place,
    String roleid,
    String keyword,
    String empid,
    String? todaylead,
    String flag,
  ) async {
    var response = await HttpApiConnect().get(
        "Lead/lead_view?place=$place&role_id=$roleid&keyword=$keyword&empid=$empid&todaylead=$todaylead&flag=$flag");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return GetShopListModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<GetShopListModel?> getShopDetails(String leadId) async {
    var response =
        await HttpApiConnect().get("Lead/lead_view_by_id?leadid=$leadId");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return GetShopListModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserUpdateModel?> updatelocation(
      {required String id, double? lat, double? log, String? location}) async {
    var add = {
      "id": id,
      "lat": lat,
      "longi": log,
      "gps_loc": location,
    };
    var response = await HttpApiConnect().post("Lead/lead_update", add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return UserUpdateModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<BranchModel?> getBranchTypes() async {
    var response = await HttpApiConnect().get("Master/branchList");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return BranchModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<StateModel?> getState() async {
    var response = await HttpApiConnect().get("Master/stateList");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return StateModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LocationModel?> getLocation(
    String id,
  ) async {
    var response =
        await HttpApiConnect().get("Master/locationList?state_id=$id");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return LocationModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ShopModel?> addShops(
      {required String date,
      required String name,
      required String contactPerson,
      required String number,
      required String email,
      required String state,
      required String place,
      required String address,
      required String pincode,
      required String currentgrade,
      int? tse,
      int? tsc,
      int? zsm,
      int? bh,
      String? leadsource,
      String? createdby,
      String? createdtype,
      String? branchid,
      String? prodcapacity,
      String? cucode,
      required String flag}) async {
    var add = {
      "date": date,
      "name": name,
      "contact_person": contactPerson,
      "mobile": number,
      "email": email,
      "state": state,
      "place": place,
      "address": address,
      "pincode": pincode,
      "lat": 0,
      "longi": 0,
      "gps_loc": "",
      "current_grade": currentgrade,
      "tse": tse,
      "tsc": tsc,
      "zsm": zsm,
      "bh": bh,
      "lead_source": leadsource,
      "created_by": createdby,
      "created_type": createdtype,
      "branch_id": branchid,
      "prod_capacity": prodcapacity,
      "cu_code": cucode,
      "flag": flag
    };
    var response = await HttpApiConnect().post("Lead/Add_lead", add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ShopModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<TeamModel?> getTeam(
    String empid,
    String roleid,
    String type,
  ) async {
    var add = {
      "empid": empid,
      "roleid": roleid,
      if (type.isNotEmpty) "type": type,
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Employee/my_team'), body: add);

    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return TeamModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AssignedRouteListResponse?> getAssignedRoutes(
      String empId, String date) async {
    var add = {
      "empid": empId,
      "date": date,
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/lead_assigned'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return AssignedRouteListResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<NotAssigedRouteListResponse?> getNotAssignedRoutes(String empId,
      String date, String keyword, String place, String flag) async {
    var add = {
      "empid": empId,
      "date": date,
      "myid": Session.userId,
      "my_roleid": Session.roleId,
      "keyword": keyword,
      "place": place,
      "flag": flag
    };
    final response = await http.post(
        Uri.parse('${BaseUrl().baseUrl}farmrouteapi/shopsnot_assigned'),
        body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return NotAssigedRouteListResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<RoutePlaceModel?> assignRoutePlace() async {
    var response =
        await HttpApiConnect().get("farmrouteapi/farmplace_routelist");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return RoutePlaceModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiModel?> assignRoute(
      String empId, String date, String leadId, String type) async {
    var add = {
      'date': date,
      'empid': empId,
      'lead_id': leadId,
      'type': type,
      'myid': Session.userId
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/assign_route'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ApiModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<MarkVisitTypesModel?> getMarkVisitTypes() async {
    var response = await HttpApiConnect().get("Lead/checkout_catlist");
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return MarkVisitTypesModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AssignRouteResponse?> assignedRoutes(String empId, String date) async {
    var add = {"empid": empId, "date": date};
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/lead_assigned'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return AssignRouteResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<SignOutResponse?> checkOutVisit(
      String type,
      String remark,
      String loc,
      String longi,
      String checkoutLat,
      String empid,
      String leadId,
      String workHour,
      String kmDiff,
      String tourPlan,
      String creditVisit,
      String roleId,
      String tourid,
      String checkinId,
      String visitType) async {
    var add = {
      "type": type,
      "remark": remark,
      "loc": loc,
      "longi": longi,
      "checkout_lat": checkoutLat,
      "empid": empid,
      "lead_id": leadId,
      "workhour": workHour,
      "km_diff1": kmDiff,
      "tourplan": tourPlan,
      "creditvisit": creditVisit,
      "roleid": roleId,
      "tour_id": tourid,
      "checkin_id": checkinId,
      "visit_type": visitType
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/checkout_visit'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return SignOutResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ShopCheckInResponse?> checkInVisit(
      String distance,
      String loc,
      String lat,
      String longi,
      String empid,
      String leadId,
      String type) async {
    var add = {
      "km_diff": distance,
      "loc": loc,
      "lati": lat,
      "longi": longi,
      "empid": empid,
      "lead_id": leadId,
      "type": type
    };
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/checkin_visit'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ShopCheckInResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ShopCheckInResponse?> checkInStatus(
      String empId, String leadId) async {
    var add = {"empid": empId, "leadid": leadId};
    final response = await http
        .post(Uri.parse('${BaseUrl().baseUrl}Lead/today_checkin'), body: add);
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ShopCheckInResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<VisitResponse?> getMyVisit(
    String date,
    String id,
  ) async {
    final response =
        await HttpApiConnect().get('Lead/list_visit?date=$date&empid=$id');
    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return VisitResponse.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
