// To parse this JSON data, do
//
//     final userdetails = userdetailsFromJson(jsonString);

import 'dart:convert';

List<Userdetails> userdetailsFromJson(String str) => List<Userdetails>.from(json.decode(str).map((x) => Userdetails.fromJson(x)));

String userdetailsToJson(List<Userdetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userdetails {
  int id;
  String name;
  String phone;
  String email;
  String address;
  String gender;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  Userdetails({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    gender: json["gender"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
    "gender": gender,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
