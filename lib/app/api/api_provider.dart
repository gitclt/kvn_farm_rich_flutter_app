import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/api/http_provider.dart';
import 'package:kvn_farm_rich/app/models/api_model.dart';
import 'package:kvn_farm_rich/app/models/auth_model.dart';
import 'package:kvn_farm_rich/app/models/login_response.dart';
import 'package:kvn_farm_rich/app/models/version_response.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';

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
}
