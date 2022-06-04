import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
  });

  final String? uid;
  final String email;
  final String name;
  final String? phoneNumber;


  @override
  List<Object?> get props => [
    uid,
    email,
    name,
    phoneNumber,
  ];
}

