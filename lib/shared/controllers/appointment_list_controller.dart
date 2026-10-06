import 'package:barberhub/shared/mocks/mock.dart';
import 'package:barberhub/shared/models/appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class AppointmentListController extends ChangeNotifier {
  final List<Appointment> appointments = List.of(mockAppointments);

  List<Appointment> appointmentsOfClient(Client client) {
    return appointments.where((item) => item.client.id == client.id).toList();
  }

  List<Appointment> appointmentsOfBarber(String barberId) {
    return appointments.where((item) => item.barber.id == barberId).toList();
  }

  Appointment createAppointment({
    required Client client,
    required Barber barber,
    required Service service,
    required DateTime dateTime,
  }) {
    final appointment = Appointment(
      id: 'a${DateTime.now().millisecondsSinceEpoch}',
      client: client,
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
