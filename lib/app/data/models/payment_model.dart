// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        this.id,
        this.date,
        this.total,
        this.paidAmount,
        this.number,
    });

    int? id;
    DateTime? date;
    num? total;
    num? paidAmount;
    String? number;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        total: json["total"] == null ? null : json["total"],
        paidAmount: json["paid_amount"] == null ? null : json["paid_amount"],
        number: json["number"] == null ? null : json["number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total": total == null ? null : total,
        "paid_amount": paidAmount == null ? null : paidAmount,
        "number": number == null ? null : number,
    };
}
