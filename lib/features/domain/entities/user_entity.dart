import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String uid;
  final String password;
  final String dob;
  final String gender;

  UserEntity({
    this.name = "",
    this.email = "",
    this.phoneNumber = "",
    this.uid = "",
    this.password = "",
    this.dob = "",
    this.gender = "",
  });

  @override
  List<Object> get props => [
        name,
        email,
        phoneNumber,
        uid,
        password,
        dob,
        gender,
      ];
}
