import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class AppointmentController extends ChangeNotifier {
  AppointmentController(this.appointmentListController) {
    // Sempre que a lista compartilhada mudar (novo agendamento na tela
    // Agendar ou um cancelamento), a lista desta tela é montada de novo.
    appointmentListController.addListener(getAppointment);
  }

  // Lista compartilhada: a mesma que a tela Agendar usa para salvar.
  final AppointmentListController appointmentListController;

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

  void getAppointment() {
    final clientAppointments = appointmentListController.appointmentsOfClient(
      currentClient,
    );

    appointmentList = clientAppointments.where((item) {
      return selectedStatusList.contains(item.status) &&
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

  // Cancela na lista compartilhada. Não precisa chamar getAppointment aqui:
  // a lista avisa os ouvintes e o listener do construtor já atualiza a tela.
  void cancelAppointment(Appointment appointment) {
    appointmentListController.cancelAppointment(appointment);
  }

  @override
  void dispose() {
    appointmentListController.removeListener(getAppointment);
    super.dispose();
  }
}