import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/debouncer.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/branch_model.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';

class ShopsController extends GetxController {
  var invoiceDate = ''.obs;
  DateTime currentDate = DateTime.now();
  var isLoading = false.obs;

  String invDate = '';
  DateTime? selectfrom;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  var searchtype = "keyword".obs;
  String stateid = '';
  var shopid = "".obs;
  var leadList = <GetLeadDetails>[].obs;
  final branchTypes = <BranchResponse>[].obs;
  String lat = '';
  String log = '';
  String locations = '';
  List<String> items = [
    "keyword",
    "Place",
  ];
  final List<String> sourceoption = [
    'Exhibition',
    'Newspaper',
    'Ads',
    'Friends',
    'Online'
  ];

  TextEditingController keywordsearchcontroller = TextEditingController();
  TextEditingController placesearchcontroller = TextEditingController();

  TextEditingController datecontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController contactPersoncontroller = TextEditingController();
  TextEditingController contactNumbercontroller = TextEditingController();
  TextEditingController currentGradecontroller = TextEditingController();
  TextEditingController branchoptioncontroller = TextEditingController();
  TextEditingController leadsourcecontroller = TextEditingController();
  TextEditingController productioncapacitycontroller = TextEditingController();
  TextEditingController cuCodecontroller = TextEditingController();
  

  @override
  void onInit() {
    getShops();
    getBranchTypes();
    super.onInit();
  }

  void getShops() async {
    isLoading(true);
    leadList.clear();
    try {
      final response = await ApiProvider().fetchLeads(
          placesearchcontroller.text,
          Session.roleId,
          keywordsearchcontroller.text,
          Session.userId,
          '1',
          "lead");
      if (response != null) {
        if (response.status == true) {
          leadList.addAll(response.data);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  final _debouncer = Debouncer(milliseconds: 1000);
  void searchTypeing(String value) {
    _debouncer.run(() {
      getShops();
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    });
  }

  picLocation(String id) async {
    final getData = await Get.toNamed(Routes.GOOGLE_MAP);
    if (getData != null) {
      final location = getData[0];
      final mapData = getData[1];
      locations = ' ${location.locality}, ${location.subLocality}';
      lat = mapData.latitude.toString();
      log = mapData.longitude.toString();
      updatelocation(id, double.parse(lat), double.parse(log), locations);
    }

    update();
  }

  updatelocation(String id, double? lat, double? log, String? location) async {
    isLoading(true);

    try {
      final response = await ApiProvider()
          .updatelocation(id: id, lat: lat, log: log, location: location);
      if (response != null) {
        if (response.status == true) {
          toast(response.message);
          getShops();
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getBranchTypes() async {
    isLoading(true);
    try {
      final response = await ApiProvider().getBranchTypes();
      if (response != null) {
        if (response.status == true) {
          branchTypes.addAll(response.data);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
