// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String fullName;
  final String? profileUrl;
  final String userID;
  final String regNo;
  final String dept;
  final String semester;
  final String phoneNo;
  final List<String>? groups;
  UserModel({
    required this.fullName,
    this.profileUrl,
    required this.userID,
    required this.regNo,
    required this.dept,
    required this.semester,
    required this.phoneNo,
    this.groups,
  });

  UserModel copyWith({
    String? fullName,
    String? profileUrl,
    String? userID,
    String? regNo,
    String? dept,
    String? semester,
    String? phoneNo,
    List<String>? groups,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      profileUrl: profileUrl ?? this.profileUrl,
      userID: userID ?? this.userID,
      regNo: regNo ?? this.regNo,
      dept: dept ?? this.dept,
      semester: semester ?? this.semester,
      phoneNo: phoneNo ?? this.phoneNo,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'profileUrl': profileUrl,
      'userID': userID,
      'regNo': regNo,
      'dept': dept,
      'semester': semester,
      'phoneNo': phoneNo,
      'groups': groups,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      userID: map['userID'] as String,
      regNo: map['regNo'] as String,
      dept: map['dept'] as String,
      semester: map['semester'] as String,
      phoneNo: map['phoneNo'] as String,
      groups: map['groups'] != null ? List<String>.from((map['groups'] as List<String>)) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(fullName: $fullName, profileUrl: $profileUrl, userID: $userID, regNo: $regNo, dept: $dept, semester: $semester, phoneNo: $phoneNo, groups: $groups)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.profileUrl == profileUrl &&
        other.userID == userID &&
        other.regNo == regNo &&
        other.dept == dept &&
        other.semester == semester &&
        other.phoneNo == phoneNo &&
        listEquals(other.groups, groups);
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        profileUrl.hashCode ^
        userID.hashCode ^
        regNo.hashCode ^
        dept.hashCode ^
        semester.hashCode ^
        phoneNo.hashCode ^
        groups.hashCode;
  }
}
