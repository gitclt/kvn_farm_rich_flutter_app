import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  bool status;
  String message;
  List<ProductData> data;

  ProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        data: List<ProductData>.from(
            json["data"].map((x) => ProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductData {
  int id;
  int catId;
  String catName;
  int subcatId;
  String subCatName;
  String name;
  String image1;
  int mrp;
  String code;
  String priunit;
  String secunit;
  String batch;
  String? expdate;
  String? mfgdate;
  String qty;

  ProductData({
    required this.id,
    required this.catId,
    required this.catName,
    required this.subcatId,
    required this.subCatName,
    required this.name,
    required this.image1,
    // required this.addedon,
    required this.mrp,
    required this.code,
    required this.priunit,
    required this.secunit,
    required this.batch,
    required this.expdate,
    required this.mfgdate,
    required this.qty,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        catId: json["cat_id"],
        catName: json["catName"] ?? "",
        subcatId: json["subcat_id"],
        subCatName: json["subCatName"],
        name: json["name"],
        image1: json["image1"],
        // addedon: json["addedon"],
        mrp: json["mrp"],
        code: json["code"],
        priunit: json["priunit"] ?? "",
        secunit: json["secunit"] ?? "",
        batch: json["batch"] ?? "",
        expdate: json["expdate"] ?? "",
        mfgdate: json["mfgdate"] ?? "",
        qty: json["qty"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "catName": catName,
        "subcat_id": subcatId,
        "subCatName": subCatName,
        "name": name,
        "image1": image1,
        // "addedon": addedon,
        "mrp": mrp,
        "code": code,
        "priunit": priunit,
        "secunit": secunit,
        "batch": batch,
        "expdate": expdate,
        "mfgdate": mfgdate,
        "qty": qty,
      };
}
