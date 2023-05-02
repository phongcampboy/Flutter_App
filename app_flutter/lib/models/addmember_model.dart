// To parse this JSON data, do
//
//     final addmember = addmemberFromJson(jsonString);

import 'dart:convert';

List<Addmember> addmemberFromJson(String str) => List<Addmember>.from(json.decode(str).map((x) => Addmember.fromJson(x)));

String addmemberToJson(List<Addmember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Addmember {
    String idSave;
    String memberStatusId;
    DateTime lpay;
    String tal;
    String memberId;
    String firstName;
    String lastName;
    String pay;
    String work;

    Addmember({
        required this.idSave,
        required this.memberStatusId,
        required this.lpay,
        required this.tal,
        required this.memberId,
        required this.firstName,
        required this.lastName,
        required this.pay,
        required this.work,
    });

    factory Addmember.fromJson(Map<String, dynamic> json) => Addmember(
        idSave: json["id_save"],
        memberStatusId: json["MemberStatusID"],
        lpay: DateTime.parse(json["Lpay"]),
        tal: json["tal"],
        memberId: json["MemberID"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        pay: json["Pay"],
        work: json["work"],
    );

    Map<String, dynamic> toJson() => {
        "id_save": idSave,
        "MemberStatusID": memberStatusId,
        "Lpay": "${lpay.year.toString().padLeft(4, '0')}-${lpay.month.toString().padLeft(2, '0')}-${lpay.day.toString().padLeft(2, '0')}",
        "tal": tal,
        "MemberID": memberId,
        "FirstName": firstName,
        "LastName": lastName,
        "Pay": pay,
        "work": work,
    };
}
