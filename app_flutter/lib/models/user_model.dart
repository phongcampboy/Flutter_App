// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.memberId = "",
    this.firstName = "",
    this.lastName = "",
    this.streetNo = "",
    this.moo = "",
    this.mooban = "",
    this.descriptionRate = "",
    this.tel1 = "",
    this.memberStatusId = "",
    this.lastPay = "",
    this.nextPay = "",
    this.total = "",
    this.amount = "",
    this.isPay = "",
    this.billingCode = "",
    this.success = "",
  });

  String memberId;
  String firstName;
  String lastName;
  String streetNo;
  String moo;
  String mooban;
  String descriptionRate;
  String tel1;
  String memberStatusId;
  String lastPay;
  String nextPay;
  String total;
  String amount;
  String isPay;
  String billingCode;
  String success;

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
