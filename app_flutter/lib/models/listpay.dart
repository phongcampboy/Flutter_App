// To parse this JSON data, do
//
//     final listpay = listpayFromJson(jsonString);

import 'dart:convert';

List<Listpay> listpayFromJson(String str) => List<Listpay>.from(json.decode(str).map((x) => Listpay.fromJson(x)));

String listpayToJson(List<Listpay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Listpay {
    String memberId;
    String total;
    DateTime lastPay;
    DateTime nextPay;

    Listpay({
        required this.memberId,
        required this.total,
        required this.lastPay,
        required this.nextPay,
    });

    factory Listpay.fromJson(Map<String, dynamic> json) => Listpay(
       memberId: json["MemberID"],
        total: json["Total"],
        lastPay: DateTime.parse(json["LastPay"]),
        nextPay: DateTime.parse(json["NextPay"]),
    );

    Map<String, dynamic> toJson() => {
        "MemberID": memberId,
        "Total": total,
        "LastPay": "${lastPay.year.toString().padLeft(4, '0')}-${lastPay.month.toString().padLeft(2, '0')}-${lastPay.day.toString().padLeft(2, '0')}",
        "NextPay": "${nextPay.year.toString().padLeft(4, '0')}-${nextPay.month.toString().padLeft(2, '0')}-${nextPay.day.toString().padLeft(2, '0')}",
    };
}




