import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_farm_rich/constraints/services/location.dart';

class GoogleMapsController extends GetxController {
  GoogleMapController? controller;
  List addressList = [];

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    controller!.dispose();
  }

  Position _position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
  bool _loading = false;
  bool get loading => _loading;

  Position get position => _position;
  Placemark _address = Placemark();

  Placemark get address => _address;

  // for get current location
  void getCurrentLocation({GoogleMapController? mapController}) async {
    _loading = true;
    update();
    try {
      Position? newLocalData = await determinePosition();

      // print(_position);

      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(newLocalData!.latitude, newLocalData.longitude),
                zoom: 17)));
        _position = newLocalData;

        List<Placemark> placemarks = await placemarkFromCoordinates(
            newLocalData.latitude, newLocalData.longitude);
        _address = placemarks.first;
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
    _loading = false;
    update();
  }

  // update position on location marker
  void updatePosition(CameraPosition position) async {
    _position = Position(
      latitude: position.target.latitude,
      longitude: position.target.longitude,
      timestamp: DateTime.now(),
      heading: 1,
      accuracy: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1, altitudeAccuracy: 1, headingAccuracy: 1,
    );
    _loading = true;
    update();
    
  }

  // End address position
  void dragableAddress() async {
    try {
      update();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);
      _address = placemarks.first;
      _loading = false;
      update();
    } catch (e) {
      _loading = false;
      update();
    }
  }

  void picLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.back(result: [_address, _position]);
  }
}
