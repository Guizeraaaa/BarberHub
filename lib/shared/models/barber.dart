import 'user.dart';
import 'userrole.dart';
 
class Barber extends User {
  final List<String> offeredServiceIds;
  final int startMinutes; 
  final int endMinutes; 
 
  Barber({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.birthDate,
    required this.offeredServiceIds,
    required this.startMinutes,
    required this.endMinutes,
  }) : super(role: Role.barber);
}
 