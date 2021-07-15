import 'dart:convert';

import 'package:flutter/material.dart';

class GetUserModel {
  GetUserModel({
    this.uid,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  });

  String? uid;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  String? displayName;
  String? photoUrl;
  String? phoneNumber;

  factory GetUserModel.fromRawJson(String str) =>
      GetUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        uid: json["uid"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        isAnonymous: json["isAnonymous"],
        displayName: json["displayName"],
        photoUrl: json["photoURL"],
        phoneNumber: json["phoneNumber"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "emailVerified": emailVerified,
        "isAnonymous": isAnonymous,
        "displayName": displayName,
        "photoURL": photoUrl,
        "phoneNumber": phoneNumber,
      };
}
