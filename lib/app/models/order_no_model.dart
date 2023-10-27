

import 'dart:convert';

OrderNoModel orderNoModelFromJson(String str) => OrderNoModel.fromJson(json.decode(str));

String orderNoModelToJson(OrderNoModel data) => json.encode(data.toJson());

class OrderNoModel {
    bool status;
    String orderNo;

    OrderNoModel({
        required this.status,
        required this.orderNo,
    });

    factory OrderNoModel.fromJson(Map<String, dynamic> json) => OrderNoModel(
        status: json["status"],
        orderNo: json["order_no"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "order_no": orderNo,
    };
}
