// To parse this JSON data, do
//
//     final contacts = contactsFromJson(jsonString);

import 'dart:convert';

Contacts contactsFromJson(String str) => Contacts.fromJson(json.decode(str));

String contactsToJson(Contacts data) => json.encode(data.toJson());

class Contacts {
    Contacts({
        this.customerId,
        this.customerName,
        this.title,
    });

    int? customerId;
    String? customerName;
    String? title;

    factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customerName: json["customer_name"] == null ? null : json["customer_name"],
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId == null ? null : customerId,
        "customer_name": customerName == null ? null : customerName,
        "title": title == null ? null : title,
    };
}
