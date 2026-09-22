import 'userrole.dart';

abstract class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime birthDate;
  final Role role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.role,
  });
}