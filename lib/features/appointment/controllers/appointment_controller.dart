import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class AppointmentController extends ChangeNotifier {
  List<Appointment> appointmentList = [];
  List<Service> serviceList = [];
  List<AppointmentStatus> selectedStatusList = [
    AppointmentStatus.agendado,
    AppointmentStatus.cancelado,
  ];

  String currentUserId = 'u2';
  // DateTime? selectedIntialDate = DateTime(2026);
  // DateTime? selectedFinalDate = DateTime(2027);
  // String? selectedStatus = 'Agendado';
  // String? selectedProfessional = 'a1';

  // bool isChipSelected = true;

  void changeSelectedChip(AppointmentStatus status) {
    if (selectedStatusList.contains(status)) {
      selectedStatusList.remove(status);
    } else {
      selectedStatusList.add(status);
    }

    notifyListeners();
  }

  void getAppointment() {
    appointmentList = mockAppointments.where((item) {
      return item.clientId == currentUserId;
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
