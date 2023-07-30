// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthData {
  final String fullName;
  final String? profileUrl;
  final String userID;
  final String regNo;
  final String dept;
  final String semester;
  final String phoneNo;
  AuthData({
    required this.fullName,
    this.profileUrl,
    required this.userID,
    required this.regNo,
    required this.dept,
    required this.semester,
    required this.phoneNo,
  });

  AuthData copyWith({
    String? fullName,
    String? profileUrl,
    String? userID,
    String? regNo,
    String? dept,
    String? semester,
    String? phoneNo,
  }) {
    return AuthData(
      fullName: fullName ?? this.fullName,
      profileUrl: profileUrl ?? this.profileUrl,
      userID: userID ?? this.userID,
      regNo: regNo ?? this.regNo,
      dept: dept ?? this.dept,
      semester: semester ?? this.semester,
      phoneNo: phoneNo ?? this.phoneNo,
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
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      fullName: map['fullName'] as String,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      userID: map['userID'] as String,
      regNo: map['regNo'] as String,
      dept: map['dept'] as String,
      semester: map['semester'] as String,
      phoneNo: map['phoneNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(fullName: $fullName, profileUrl: $profileUrl, userID: $userID, regNo: $regNo, dept: $dept, semester: $semester, phoneNo: $phoneNo)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.profileUrl == profileUrl &&
        other.userID == userID &&
        other.regNo == regNo &&
        other.dept == dept &&
        other.semester == semester &&
        other.phoneNo == phoneNo;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^ profileUrl.hashCode ^ userID.hashCode ^ regNo.hashCode ^ dept.hashCode ^ semester.hashCode ^ phoneNo.hashCode;
  }
}
