import 'package:barberhub/shared/models/Appointment.dart';
import 'package:flutter/material.dart';

DateTime _dayAt(int daysFromToday, int hour, int minute) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + daysFromToday, hour, minute);
}

class AppointmentController extends ChangeNotifier {
  List<Appointment> appointmentList = [
    Appointment(
      id: 'a8',
      clientId: 'u3',
      barberId: 'b1',
      serviceId: 's1',
      dateTime: _dayAt(1, 10, 0),
      status: AppointmentStatus.agendado,
      price: 45.0,
      durationMinutes: 30,
    ),
    Appointment(
      id: 'a1',
      clientId: 'u1',
      barberId: 'b1',
      serviceId: 's1',
      dateTime: _dayAt(-3, 10, 0),
      status: AppointmentStatus.concluido,
      price: 45.0,
      durationMinutes: 30,
    ),
  ];
}
