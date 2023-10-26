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
  String qty;
  int mrp;

  ProductData({
    required this.id,
    required this.catId,
    required this.catName,
    required this.subcatId,
    required this.subCatName,
    required this.name,
    required this.image1,
    required this.qty,
    required this.mrp,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        catId: json["cat_id"],
        catName: json["catName"],
        subcatId: json["subcat_id"],
        subCatName: json["subCatName"],
        name: json["name"],
        image1: json["image1"],
        qty: json["qty"] ?? "",
        mrp: json["mrp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "catName": catName,
        "subcat_id": subcatId,
        "subCatName": subCatName,
        "name": name,
        "image1": image1,
        "qty": qty,
        "mrp": mrp,
      };
}
