import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class AppointmentListController extends ChangeNotifier {
  final List<Appointment> appointments = List.of(mockAppointments);

  List<Appointment> appointmentsOfClient(String clientId) {
    return appointments.where((item) => item.clientId == clientId).toList();
  }

  List<Appointment> appointmentsOfBarber(String barberId) {
    return appointments.where((item) => item.barber.id == barberId).toList();
  }

  Appointment createAppointment({
    required String clientId,
    required Barber barber,
    required Service service,
    required DateTime dateTime,
  }) {
    final appointment = Appointment(
      id: 'a${DateTime.now()}',
      clientId: clientId,
      barber: barber,
      service: service,
      dateTime: dateTime,
      status: AppointmentStatus.agendado,
    );

    appointments.add(appointment);
    notifyListeners();
    return appointment;
  }
}
