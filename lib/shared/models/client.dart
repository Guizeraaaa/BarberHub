import 'user.dart';
import 'userrole.dart';

class Client extends User {
  Client({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.birthDate,
  }) : super(role: Role.client);
}