import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/client.dart';
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

  Client currentClient = mockClients[1];

  String selectedProfessional = '';
  String selectedService = '';
  DateTimeRange<DateTime>? selectedDateRange;

  void changeSelectedProfessional(String value) {
    selectedProfessional = value;
  }

  void changeSelectedService(String value) {
    selectedService = value;
  }

  void changeSelectedDateRange(DateTimeRange<DateTime> value) {
    selectedDateRange = value;
    notifyListeners();
  }

  void changeSelectedChip(AppointmentStatus status) {
    if (selectedStatusList.contains(status)) {
      selectedStatusList.remove(status);
    } else {
      selectedStatusList.add(status);
    }

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
    selectedDateRange = null;

    getAppointment();
    notifyListeners();
  }

  void applyFilters({
    required List<AppointmentStatus> statusList,
    required String professional,
    required String service,
    required DateTimeRange<DateTime>? dateRange,
  }) {
    selectedStatusList = List.of(statusList);
    selectedProfessional = professional;
    selectedService = service;
    selectedDateRange = dateRange;

    updateFilters();
  }

  void updateFilters() {
    getAppointment();
    notifyListeners();
  }

  void getAppointment() {
    appointmentList = mockAppointments.where((item) {
      return item.client.id == currentClient.id;
    }).toList();

    appointmentList.sort((a, b) {
      final aAgendado = a.status == AppointmentStatus.agendado;
      final bAgendado = b.status == AppointmentStatus.agendado;

      if (aAgendado && !bAgendado) return -1;
      if (!aAgendado && bAgendado) return 1;

      return a.dateTime.compareTo(b.dateTime);
    });

    notifyListeners();
  }

  bool _isInsideSelectedDateRange(DateTime date) {
    final range = selectedDateRange;
    if (range == null) return true;

    final start = DateTime(
      range.start.year,
      range.start.month,
      range.start.day,
    );
    final endExclusive = DateTime(
      range.end.year,
      range.end.month,
      range.end.day + 1,
    );

    return !date.isBefore(start) && date.isBefore(endExclusive);
  }

  void cancelAppointment(Appointment appointment) {
    // appointment.status = AppointmentStatus.cancelado;
  }
}
