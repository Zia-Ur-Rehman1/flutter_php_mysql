// ignore: file_names
import 'package:flutter/cupertino.dart';

class Employee {
  String id;
  String name;
  String email;
  String phone;
  String address;
  Employee({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });
  
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
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
