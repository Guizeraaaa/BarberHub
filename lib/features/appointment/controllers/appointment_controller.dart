import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';
import 'package:barberhub/shared/controllers/appointment_list_controller.dart';

class AppointmentController extends ChangeNotifier {
  AppointmentController(
    this.appointmentListController,
    this.loginController,
    this.serviceListController,
  );

  final AppointmentListController appointmentListController;
  final LoginController loginController;
  final ServiceListController serviceListController;

  List<Appointment> appointmentList = [];
  List<AppointmentStatus> selectedStatusList = [
    AppointmentStatus.agendado,
    AppointmentStatus.cancelado,
    AppointmentStatus.concluido,
  ];
  List<Barber> professionalsList = mockBarbers;

  List<Service> get servicesList => serviceListController.servicesList;

  bool get isBarber => loginController.isBarber;

  String selectedProfessional = '';
  String selectedService = '';
  DateTimeRange<DateTime>? selectedDateRange;

  void loadAppointments() {
    selectedStatusList = [
      AppointmentStatus.agendado,
      AppointmentStatus.cancelado,
      AppointmentStatus.concluido,
    ];
    selectedProfessional = '';
    selectedService = '';

    if (isBarber) {
      final today = DateUtils.dateOnly(DateTime.now());
      selectedDateRange = DateTimeRange(start: today, end: today);
    } else {
      selectedDateRange = null;
    }

    getAppointment();
  }

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

    updateFilters();
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

  bool _belongsToCurrentUser(Appointment item) {
    final barber = loginController.currentBarber;
    if (barber != null) {
      return item.barber.id == barber.id;
    }

    final client = loginController.currentClient;
    if (client != null) {
      return item.client.id == client.id;
    }

    return false;
  }

  void getAppointment() {
    appointmentList = appointmentListController.appointments.where((item) {
      return _belongsToCurrentUser(item) &&
          selectedStatusList.contains(item.status) &&
          _isInsideSelectedDateRange(item.dateTime) &&
          (selectedProfessional == '' ||
              item.barber.name == selectedProfessional) &&
          (selectedService == '' || item.service.name == selectedService);
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

  bool canCancel(Appointment appointment) {
    return appointment.status == AppointmentStatus.agendado &&
        appointment.dateTime.isAfter(DateTime.now());
  }

  bool canComplete(Appointment appointment) {
    return isBarber && appointment.status == AppointmentStatus.agendado;
  }

  void cancelAppointment(Appointment appointment) {
    appointment.status = AppointmentStatus.cancelado;
    getAppointment();
  }

  void completeAppointment(Appointment appointment) {
    appointment.status = AppointmentStatus.concluido;
    getAppointment();
  }
}
