import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class AppointmentController extends ChangeNotifier {
  List<Appointment> appointmentList = [];
  List<AppointmentStatus> selectedStatusList = [
    AppointmentStatus.agendado,
    AppointmentStatus.cancelado,
    AppointmentStatus.concluido,
  ];
  List<Barber> professionalsList = mockBarbers;
  List<Service> servicesList = mockServices;

  String currentUserId = 'u2';

  String selectedProfessional = '';
  String selectedService = '';

  void changeSelectedProfessional(String value) {
    selectedProfessional = value;
  }

  void changeSelectedService(String value) {
    selectedService = value;
  }

  // DateTime? selectedIntialDate = DateTime(2026);
  // DateTime? selectedFinalDate = DateTime(2027);

  void changeSelectedChip(AppointmentStatus status) {
    if (selectedStatusList.contains(status)) {
      selectedStatusList.remove(status);
    } else {
      selectedStatusList.add(status);
    }

    notifyListeners();
  }

  void exitFilters() {
    selectedStatusList = [
      AppointmentStatus.agendado,
      AppointmentStatus.cancelado,
      AppointmentStatus.concluido,
    ];
    selectedProfessional = '';
    selectedService = '';

    notifyListeners();
  }

  void clearFilters() {
    selectedStatusList = [
      AppointmentStatus.agendado,
      AppointmentStatus.cancelado,
      AppointmentStatus.concluido,
    ];
    selectedProfessional = '';
    selectedService = '';

    getAppointment();
    notifyListeners();
  }

  void updateFilters() {
    getAppointment();
    notifyListeners();
  }

  void getAppointment() {
    appointmentList = mockAppointments.where((item) {
      return item.clientId == currentUserId &&
          selectedStatusList.contains(item.status) &&
          (selectedProfessional == '' ||
              item.barber.name == selectedProfessional) &&
          (selectedService == '' || item.service.name == selectedService);
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
