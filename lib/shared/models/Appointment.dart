enum AppointmentStatus { agendado, concluido, cancelado }
 
class Appointment {
  final String id;
  final String clientId;
  final String barberId;
  final String serviceId;
  final DateTime dateTime;
  final AppointmentStatus status;
  final double price; 
  final int durationMinutes; 
 
  Appointment({
    required this.id,
    required this.clientId,
    required this.barberId,
    required this.serviceId,
    required this.dateTime,
    required this.status,
    required this.price,
    required this.durationMinutes,
  });
}
 


