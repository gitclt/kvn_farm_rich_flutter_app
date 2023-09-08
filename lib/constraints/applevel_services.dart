import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLevelServices {
  Future onInitApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: red2Color.withOpacity(0.9)));
  }
}
