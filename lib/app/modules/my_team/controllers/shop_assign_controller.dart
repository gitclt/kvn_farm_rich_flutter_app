import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/debouncer.dart';
import 'package:kvn_farm_rich/app/models/assigned_route_model.dart';
import 'package:kvn_farm_rich/app/models/not_assigned_route_model.dart';
import 'package:kvn_farm_rich/app/models/route_place_model.dart';

class ShopAssignController extends GetxController {
  var isLoading = false.obs;
  var isAssignLoading = false.obs;
  final value = Get.arguments;
  DateTime date = DateTime.now();
  //final String placeList = '';
  final placeLoading = false.obs;
  RxString selectedRoute = 'Select Place'.obs;
  final routePlaceList = <Routes>[].obs;
  final placeList = <Place>[].obs;
  String keyword = '';

  TextEditingController keywordController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController statusController = TextEditingController(text: 'Live');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedDate = '';
  final List<String> status = [
    'Live',
    'Work from Home',
  ];

  @override
  void onInit() async {
    super.onInit();
    selectedDate = '${date.year}-${date.month}-${date.day}';
    assignRoute();
    getAssignedRoutes();
  }

  void uncheckValues() {
    for (var element in routePlaceList) {
      for (var element in element.places) {
        element.isSelect.value = false;
      }
    }
  }

  assignRoute() async {
    isLoading(true);
    // routePlaceList.clear();
    try {
      final response = await ApiProvider().assignRoutePlace();
      if (response != null) {
        if (response.status) {
          routePlaceList.addAll(response.data);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  getAssignedPlaces() async {
    final selectedPlace = routePlaceList
        .map((element) =>
            element.places.where((element) => element.isSelect.value == true))
        .toList();

    final place = selectedPlace
        .where((element) => element.any((e) => e.isSelect.value) == true)
        .toList();
    for (var item in place) {
      final placeList = item.map((e) => e.name).toList();

      return placeList;
    }
  }

  void changeDate(DateTime newDate) {
    selectedDate = '${newDate.year}-${newDate.month}-${newDate.day}';
    getAssignedRoutes();
  }

  List<String> fitems = ["Prospective1", "Prospective2"];
  List<String> kitems = ["Search by ShopName", "Search by Place"];
  RxString filterresponse = 'Prospective1'.obs;
  //RxString searchResponse = 'keyword'.obs;
  RxList<NotAssignedRoute> notrouteListResponse = <NotAssignedRoute>[].obs;
  RxList<NotAssignedRoute> shopsMarkedResponse = <NotAssignedRoute>[].obs;
  RxList<RouteDatum> routeListResponse = <RouteDatum>[].obs;

  void getAssignedRoutes() async {
    isLoading(true);
    routeListResponse.clear();
    try {
      final response = await ApiProvider()
          .getAssignedRoutes(value.id.toString(), selectedDate);
      if (response != null) {
        if (response.status == true) {
          routeListResponse.addAll(response.routeData!);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  final _debouncer = Debouncer(milliseconds: 1000);
  void onSearch(String value) {
    _debouncer.run(() {
      keyword = value;
      getNotAssignedRoutes();
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    });
  }

  void getNotAssignedRoutes() async {
    isLoading(true);
    notrouteListResponse.clear();
    try {
      final response = await ApiProvider().getNotAssignedRoutes(
          value.id.toString(),
          selectedDate,
          keyword,
          selectedRoute.value == 'Select Place' ? "" : selectedRoute.value,
          "customer");
      if (response != null) {
        if (response.status == true) {
          notrouteListResponse.addAll(response.notAssignedRoute!);
          keyword = '';
          
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void assiginRoute() async {
    isAssignLoading(true);
    try {
      final selectedRoutes = notrouteListResponse
          .where((p0) => p0.isSelect.value == true)
          .toList();

      for (var item in selectedRoutes) {
        // if (item.lat != '0.0') {
        await addRoute(
            date: selectedDate,
            type: item.type.toString(),
            leadId: item.id.toString());
        // } else {
        //   toast('Location Not Updated');
        // }
        // await DatabaseHelper()
        //     .addRoute(selectedDate, dropValue, item.id.toString());
      }
      isAssignLoading(false);

      Get.back();
      getAssignedRoutes();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addRoute(
      {required String date,
      required String type,
      required String leadId}) async {
    try {
      final response = await ApiProvider()
          .assignRoute(value.id.toString(), date, leadId, type);
      if (response != null) {
        if (response.status == true) {
          return;
        } else {}
      }
    } finally {}
  }
}
