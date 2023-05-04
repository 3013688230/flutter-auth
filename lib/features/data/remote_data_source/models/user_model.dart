import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String name = "username",
    String email = "",
    String phoneNumber = "",
    String uid = "",
    String profileUrl = "",
    String dob = "",
    String gender = "",
  }) : super(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          uid: uid,
          gender: gender,
          dob: dob,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      uid: json['uid'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      uid: snapshot.get('uid'),
      dob: snapshot.get('dob'),
      gender: snapshot.get('gender'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "dob": dob,
      "gender": gender,
    };
  }
}
