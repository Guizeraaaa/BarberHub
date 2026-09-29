import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

class SchedulingController extends ChangeNotifier {
  List<Service> servicesList = mockServices;
  List<Barber> professionalsList = [];
  List<String> slotsList = [];

  String currentUserId = 'u2';

  Service? selectedService;
  Barber? selectedProfessional;
  DateTime selectedDate = DateTime.now();
  String selectedSlot = '';

  // Intervalo entre um horário e outro na grade (em minutos).
  final int slotInterval = 30;

  bool get canConfirm {
    return selectedService != null &&
        selectedProfessional != null &&
        selectedSlot != '';
  }

  void initScheduling() {
    selectedService = servicesList.first;
    selectedProfessional = null;
    selectedDate = DateTime.now();

    getProfessionals();
    getSlots();
  }

  void changeSelectedService(Service service) {
    selectedService = service;

    getProfessionals();
    getSlots();
  }

  void changeSelectedProfessional(Barber professional) {
    selectedProfessional = professional;

    getSlots();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;

    getSlots();
  }

  void changeSelectedSlot(String slot) {
    selectedSlot = slot;

    notifyListeners();
  }

  // Só aparecem os profissionais que fazem o serviço escolhido.
  void getProfessionals() {
    professionalsList = mockBarbers.where((item) {
      return item.offeredServiceIds.contains(selectedService?.id);
    }).toList();

    // Se o profissional escolhido não faz esse serviço, troca pelo primeiro que faz.
    if (!professionalsList.contains(selectedProfessional)) {
      selectedProfessional = professionalsList.isEmpty
          ? null
          : professionalsList.first;
    }
  }

  // Monta a lista de horários livres do profissional no dia escolhido.
  void getSlots() {
    slotsList = [];
    selectedSlot = '';

    if (selectedService == null || selectedProfessional == null) {
      notifyListeners();
      return;
    }

    final professional = selectedProfessional!;
    final duration = selectedService!.durationMinutes;
    final day = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    for (
      int minutes = professional.startMinutes;
      minutes + duration <= professional.endMinutes;
      minutes += slotInterval
    ) {
      final start = day.add(Duration(minutes: minutes));
      final end = start.add(Duration(minutes: duration));

      // Não mostra horário que já passou.
      if (start.isBefore(DateTime.now())) {
        continue;
      }

      if (isProfessionalBusy(professional, start, end)) {
        continue;
      }

      slotsList.add(Utils.hourFormat(start));
    }

    notifyListeners();
  }

  // Verifica se o profissional já tem um agendamento que bate com esse horário.
  bool isProfessionalBusy(Barber professional, DateTime start, DateTime end) {
    for (final appointment in mockAppointments) {
      if (appointment.barber.id != professional.id) {
        continue;
      }
      if (appointment.status != AppointmentStatus.agendado) {
        continue;
      }

      final appointmentStart = appointment.dateTime;
      final appointmentEnd = appointmentStart.add(
        Duration(minutes: appointment.service.durationMinutes),
      );

      if (start.isBefore(appointmentEnd) && appointmentStart.isBefore(end)) {
        return true;
      }
    }

    return false;
  }

  // Cria o agendamento e devolve ele (ou null se faltar alguma escolha).
  Appointment? confirmAppointment() {
    if (!canConfirm) {
      return null;
    }

    final hour = int.parse(selectedSlot.split(':')[0]);
    final minute = int.parse(selectedSlot.split(':')[1]);

    final appointment = Appointment(
      id: 'a${DateTime.now().millisecondsSinceEpoch}',
      clientId: currentUserId,
      barber: selectedProfessional!,
      service: selectedService!,
      dateTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        hour,
        minute,
      ),
      status: AppointmentStatus.agendado,
    );

    mockAppointments.add(appointment);

    // Atualiza a grade: o horário que acabou de ser marcado some.
    getSlots();

    return appointment;
  }
}
