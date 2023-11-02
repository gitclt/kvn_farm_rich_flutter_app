import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  bool status;
  List<OrderData> data;

  OrderListModel({
    required this.status,
    required this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        status: json["status"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  int leadId;
  String leadname;
  String orderNo;
  int qty;
  String status;
  String date;

  OrderData(
      {required this.leadId,
      required this.leadname,
      required this.orderNo,
      required this.qty,
      required this.status,
      required this.date});

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        leadId: json["lead_id"],
        leadname: json["leadname"],
        orderNo: json["orderNo"],
        qty: json["qty"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "lead_id": leadId,
        "leadname": leadname,
        "orderNo": orderNo,
        "qty": qty,
        "status": status,
        "date": date
      };
}
