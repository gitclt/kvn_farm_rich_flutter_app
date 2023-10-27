import 'dart:convert';

OrderByDateModel orderByDateModelFromJson(String str) =>
    OrderByDateModel.fromJson(json.decode(str));

String orderByDateModelToJson(OrderByDateModel data) =>
    json.encode(data.toJson());

class OrderByDateModel {
  bool status;
  List<Message> message;

  OrderByDateModel({
    required this.status,
    required this.message,
  });

  factory OrderByDateModel.fromJson(Map<String, dynamic> json) =>
      OrderByDateModel(
        status: json["status"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  int leadId;
  String orderNo;
  String status;
  int qty;
  DateTime date;

  Message({
    required this.leadId,
    required this.orderNo,
    required this.status,
    required this.qty,
    required this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        leadId: json["lead_id"],
        orderNo: json["orderNo"],
        status: json["status"],
        qty: json["qty"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "lead_id": leadId,
        "orderNo": orderNo,
        "status": status,
        "qty": qty,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
