// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
    Usermodel({
        required this.memberId,
        required this.firstName,
        required this.lastName,
        required this.streetNo,
        required this.moo,
        required this.mooban,
        required this.descriptionRate,
        required this.tel1,
        required this.memberStatusId,
        required this.lastPay,
        required this.nextPay,
        required this.total,
        required this.amount,
        required this.isPay,
        required this.billingCode,
        required this.success,
    });

    String memberId = "";
    String firstName = "";
    String lastName = "";
    String streetNo = "";
    String moo = "";
    String mooban = "";
    String descriptionRate = "";
    String tel1 = "";
    String memberStatusId = "";
    String lastPay = "";
    String nextPay = "";
    String total = "";
    String amount = "";
    String isPay = "";
    String billingCode = "";
    String success = "";

    factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        memberId: json["MemberID"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        streetNo: json["StreetNo"],
        moo: json["Moo"],
        mooban: json["Mooban"],
        descriptionRate: json["DescriptionRate"],
        tel1: json["Tel1"],
        memberStatusId: json["MemberStatusID"],
        lastPay: json["LastPay"],
        nextPay: json["NextPay"],
        total: json["Total"],
        amount: json["Amount"],
        isPay: json["IsPay"],
        billingCode: json["BillingCode"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "MemberID": memberId,
        "FirstName": firstName,
        "LastName": lastName,
        "StreetNo": streetNo,
        "Moo": moo,
        "Mooban": mooban,
        "DescriptionRate": descriptionRate,
        "Tel1": tel1,
        "MemberStatusID": memberStatusId,
        "LastPay": lastPay,
        "NextPay": nextPay,
        "Total": total,
        "Amount": amount,
        "IsPay": isPay,
        "BillingCode": billingCode,
        "success": success,
    };
}
