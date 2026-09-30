import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:flutter/material.dart';

class AppointmentController extends ChangeNotifier {
  DateTime? selectedIntialDate = DateTime(2026);
  DateTime? selectedFinalDate = DateTime(2027);
  String? selectedStatus = 'Agendado';
  String? selectedProfessional = 'a1';
  List<Appointment> appointmentList = [];

  Client currentClient = mockClients[1];

  void getAppointment() {
    appointmentList = mockAppointments.where((item) {
      return item.client.id == currentClient.id;
    }).toList();

    appointmentList.sort((a, b) {
      final aAgendado = a.status == AppointmentStatus.agendado;
      final bAgendado = b.status == AppointmentStatus.agendado;

      // Agendados ficam sempre no topo
      if (aAgendado && !bAgendado) return -1;
      if (!aAgendado && bAgendado) return 1;

      // Dentro do mesmo grupo, ordena pela data
      return a.dateTime.compareTo(b.dateTime);
    });
    notifyListeners();
  }
}
