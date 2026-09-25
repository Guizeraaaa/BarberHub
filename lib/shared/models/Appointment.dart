import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';

enum AppointmentStatus { agendado, concluido, cancelado }

class Appointment {
  final String id;
  final String clientId;
  final Barber barber;
  final Service service;
  final DateTime dateTime;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.clientId,
    required this.barber,
    required this.service,
    required this.dateTime,
    required this.status,
  });
}
