// To parse this JSON data, do
//
//     final listpay = listpayFromJson(jsonString);

import 'dart:convert';

List<Listpay> listpayFromJson(String str) =>
    List<Listpay>.from(json.decode(str).map((x) => Listpay.fromJson(x)));

String listpayToJson(List<Listpay> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Listpay {
  String memberId;
  String total;
  String lastPay;
  String nextPay;

  Listpay({
    required this.memberId,
    required this.total,
    required this.lastPay,
    required this.nextPay,
  });

  factory Listpay.fromJson(Map<String, dynamic> json) => Listpay(
        memberId: json["MemberID"],
        total: json["Total"],
        lastPay: json["lastPay"],
        nextPay: json["nextPay"],
      );

  Map<String, dynamic> toJson() => {
        "MemberID": memberId,
        "Total": total,
        "lastPay": lastPay,
        "nextPay": nextPay,
      };
}
