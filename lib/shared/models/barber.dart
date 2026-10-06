import 'package:barberhub/shared/models/service.dart';

import 'user.dart';
import 'role.dart';

class Barber extends User {
  final List<Service> offeredService;
  final int startMinutes;
  final int endMinutes;

  Barber({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.birthDate,
    required this.offeredService,
    required this.startMinutes,
    required this.endMinutes,
  }) : super(role: Role.barber);
}
