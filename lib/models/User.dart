import 'package:flutter/material.dart';

class User {
  final String userID,
      userSurname,
      userName,
      email,
      phoneNumber,
      address,
      imageUrl,
      role;
  final int birthday;

  User({this.userID,
    this.userSurname,
    this.userName,
    this.email,
    this.phoneNumber,
    this.address,
    this.imageUrl,
    this.role,
    this.birthday});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userID: json['userID'],
        userName: json['userName'],
        userSurname: json['userSurname'],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        imageUrl: json['imageURL'],
        role: json['role'],
        birthday: json['birthday']);
  }

  factory User.fromLoginJson(Map<String, dynamic> json) {
    User u = json['userInfo'] != null
        ? json['userInfo'].map<User>((json) => User.fromJson(json))
        : null;
    return u;
  }
}
