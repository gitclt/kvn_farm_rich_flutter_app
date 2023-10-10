import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/api/http_provider.dart';
import 'package:kvn_farm_rich/app/models/api_model.dart';
import 'package:kvn_farm_rich/app/models/attendance_report_model.dart';
import 'package:kvn_farm_rich/app/models/auth_model.dart';
import 'package:kvn_farm_rich/app/models/login_response.dart';
import 'package:kvn_farm_rich/app/models/signout_response.dart';
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
}
