// ignore: file_names
import 'package:flutter/cupertino.dart';

class Employee {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  Employee({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });
  
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: int.parse(json['id']),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
    );
  }

  get getname => this.name;
  get getemail => this.email;
  get getphone => this.phone;
  get getaddress => this.address;

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, email: $email, phone: $phone, address: $address)';
  }
}
