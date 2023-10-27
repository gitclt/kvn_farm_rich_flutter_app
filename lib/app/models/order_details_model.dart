import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  bool status;
  List<OrderDetail> data;

  OrderDetailsModel({
    required this.status,
    required this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        status: json["status"],
        data: List<OrderDetail>.from(
            json["data"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderDetail {
  int id;
  int catid;
  String name;
  int subcatId;
  String subcatName;
  String productname;
  String status;
  int leadid;
  String leadname;
  String place;
  String orderNo;
  int qty;
  DateTime date;
  String image1;
  String code;

  OrderDetail({
    required this.id,
    required this.catid,
    required this.name,
    required this.subcatId,
    required this.subcatName,
    required this.productname,
    required this.status,
    required this.leadid,
    required this.leadname,
    required this.place,
    required this.orderNo,
    required this.qty,
    required this.date,
    required this.image1,
    required this.code,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        catid: json["catid"],
        name: json["name"],
        subcatId: json["subcat_id"],
        subcatName: json["subcat_name"],
        productname: json["productname"],
        status: json["status"],
        leadid: json["leadid"],
        leadname: json["leadname"],
        place: json["place"],
        orderNo: json["order_no"],
        qty: json["qty"],
        date: DateTime.parse(json["date"]),
        image1: json["image1"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "catid": catid,
        "name": name,
        "subcat_id": subcatId,
        "subcat_name": subcatName,
        "productname": productname,
        "status": status,
        "leadid": leadid,
        "leadname": leadname,
        "place": place,
        "order_no": orderNo,
        "qty": qty,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "image1": image1,
        "code": code,
      };
}
