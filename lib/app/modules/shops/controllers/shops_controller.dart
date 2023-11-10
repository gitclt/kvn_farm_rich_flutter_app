import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/debouncer.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/shop_location_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/branch_model.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/models/state_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class ShopsController extends GetxController {
  var invoiceDate = ''.obs;
  DateTime currentDate = DateTime.now();
  var isLoading = false.obs;
  var stateList = <StateDetails>[].obs;
  String invDate = '';
  String shopId = '';
  DateTime? selectfrom;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  String addLeaddate = dateFormat5(DateTime.now());
  GetShopDetails? shopDetailsResponse;
  var editLoading = false.obs;

  var searchtype = "keyword".obs;
  String stateid = '';
  var shopid = "".obs;
  var isDetailsLoading = false.obs;
  var leadList = <GetShopDetails>[].obs;
  final branchTypes = <BranchResponse>[].obs;
  String lat = '';
  String log = '';
  String locations = '';
  List<String> items = [
    "keyword",
    "Place",
  ];

  TextEditingController keywordsearchcontroller = TextEditingController();
  TextEditingController placesearchcontroller = TextEditingController();

  TextEditingController statecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController contactPersoncontroller = TextEditingController();
  TextEditingController contactNumbercontroller = TextEditingController();

  TextEditingController branchoptioncontroller = TextEditingController();

  TextEditingController cuCodecontroller = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      shopId = Get.arguments;
      viewLeadDetails(shopId);
    }
    getShops();
    getBranchTypes();
    super.onInit();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    contactPersoncontroller.dispose();
    contactNumbercontroller.dispose();
    emailcontroller.dispose();
    statecontroller.dispose();
    locationcontroller.dispose();
    addresscontroller.dispose();
    pincodecontroller.dispose();
    branchoptioncontroller.dispose();
    cuCodecontroller.dispose();
    super.dispose();
  }

  void getShops() async {
    isLoading(true);
    leadList.clear();
    try {
      final response = await ApiProvider().fetchLeads(
          placesearchcontroller.text,
          "1",
          keywordsearchcontroller.text,
          Session.userId,
          '',
          "customer");
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

  viewLeadDetails(String shopId) async {
    isDetailsLoading(true);
    clear();
    try {
      final response = await ApiProvider().getShopDetails(shopId);
      if (response != null) {
        if (response.status == true) {
          shopDetailsResponse = response.data.first;
          await getStateId();
          updateTextValue();
        } else {
          isDetailsLoading(false);
        }
      }
    } finally {
      isDetailsLoading(false);
    }
  }

  void updateTextValue() {
    locationcontroller =
        TextEditingController(text: shopDetailsResponse!.place);
    statecontroller = TextEditingController(text: shopDetailsResponse!.state);
    namecontroller = TextEditingController(text: shopDetailsResponse!.name);
    addresscontroller =
        TextEditingController(text: shopDetailsResponse!.address);
    pincodecontroller =
        TextEditingController(text: shopDetailsResponse!.pincode);
    emailcontroller = TextEditingController(text: shopDetailsResponse!.email);
    contactPersoncontroller =
        TextEditingController(text: shopDetailsResponse!.contactPerson);
  }

  void editLeads(String leadValue) async {
    editLoading(true);

    try {
      final response = await ApiProvider().editLeads(
        id: leadValue,
        name: namecontroller.text == ''
            ? shopDetailsResponse!.name
            : namecontroller.text,
        contactPerson: contactPersoncontroller.text == ''
            ? shopDetailsResponse!.contactPerson
            : contactPersoncontroller.text,
        email: emailcontroller.text == ''
            ? shopDetailsResponse!.email
            : emailcontroller.text,
        state: statecontroller.text == ''
            ? shopDetailsResponse!.state
            : statecontroller.text,
        place: locationcontroller.text == ''
            ? shopDetailsResponse!.place
            : locationcontroller.text,
        address: addresscontroller.text == ''
            ? shopDetailsResponse!.address
            : addresscontroller.text,
        pincode: pincodecontroller.text == ''
            ? shopDetailsResponse!.pincode
            : pincodecontroller.text,
      );
      if (response != null) {
        if (response.status == true) {
          toast(
            response.message,
          );

          Get.close(2);
          getShops();
        } else {
          editLoading(false);
        }
      }
    } finally {
      editLoading(false);
    }
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

  clear() {
    namecontroller.clear();
    contactPersoncontroller.clear();
    contactNumbercontroller.clear();
    emailcontroller.clear();
    statecontroller.clear();
    locationcontroller.clear();
    addresscontroller.clear();
    pincodecontroller.clear();
    branchoptioncontroller.clear();
    cuCodecontroller.clear();
  }

  addShops() async {
    isLoading(true);
    try {
      final response = await ApiProvider().addShops(
          date: addLeaddate,
          name: namecontroller.text,
          contactPerson: contactPersoncontroller.text,
          number: contactNumbercontroller.text,
          email: emailcontroller.text,
          state: statecontroller.text,
          place: locationcontroller.text,
          address: addresscontroller.text,
          pincode: pincodecontroller.text,
          currentgrade: 'A',
          tse: 0,
          tsc: 0,
          zsm: 0,
          bh: 0,
          leadsource: "Online",
          createdby: Session.userId,
          createdtype: Session.roleId,
          branchid: branchoptioncontroller.text,
          prodcapacity: "0",
          cucode: cuCodecontroller.text,
          flag: "customer");
      if (response != null) {
        if (response.status == true) {
          toast(
            response.message,
          );
          clear();
          Get.close(1);
          getShops();
          shopLocationPopup(() {
            picLocation(response.data!.id.toString());
          }, () {
            Get.back();
          });
        } else {
          toast(response.message);
          clear();
          Get.close(1);
          getShops();
        }
      }
    } finally {
      isLoading(false);
    }
  }

  getStateId() async {
    // isLoading(true);

    try {
      final response = await ApiProvider().getState();
      if (response != null) {
        if (response.status == true) {
          stateList.addAll(
              response.data.where((e) => e.name == shopDetailsResponse!.state));
        } else {
          isLoading(false);
        }
      }
    } finally {
      // isLoading(false);
    }
  }
}
