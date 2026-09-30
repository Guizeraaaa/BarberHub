import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

class SchedulingController extends ChangeNotifier {
  SchedulingController(this.appointmentListController);

  // Lista compartilhada: é aqui que o novo agendamento é salvo.
  final AppointmentListController appointmentListController;

  // Mesmo usuário fixo do AppointmentController do Lucas ('u2'),
  // até o login guardar quem está logado.
  String currentUserId = 'u2';

  // Distância entre um horário e o próximo na grade (09:00, 09:30, ...).
  final int slotStepMinutes = 30;

  // Até quantos dias pra frente o cliente pode agendar.
  final int maxDaysAhead = 30;

  List<Service> servicesList = mockServices;
  List<Barber> barbersList = mockBarbers;

  Service selectedService = mockServices[0];
  Barber selectedBarber = mockBarbers[0];
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  String? selectedSlot;

  DateTime get firstDate => DateUtils.dateOnly(DateTime.now());

  DateTime get lastDate => firstDate.add(Duration(days: maxDaysAhead));

  bool get canConfirm => selectedSlot != null;

  // Só os barbeiros que fazem o serviço escolhido.
  List<Barber> barbersForSelectedService() {
    return barbersList
        .where(
          (barber) => barber.offeredServiceIds.contains(selectedService.id),
        )
        .toList();
  }

  void selectService(Service service) {
    selectedService = service;

    // Se o barbeiro atual não faz esse serviço, troca pelo primeiro que faz.
    final barbers = barbersForSelectedService();
    if (!barbers.contains(selectedBarber)) {
      selectedBarber = barbers.first;
    }

    selectedSlot = null;
    notifyListeners();
  }

  void selectBarber(Barber barber) {
    selectedBarber = barber;
    selectedSlot = null;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    selectedDate = DateUtils.dateOnly(date);
    selectedSlot = null;
    notifyListeners();
  }

  void selectSlot(String slot) {
    selectedSlot = slot;
    notifyListeners();
  }

  // Monta os horários livres do barbeiro no dia escolhido.
  // Um horário entra na lista quando:
  // - o serviço inteiro cabe antes do fim do expediente;
  // - ainda não passou (para o dia de hoje);
  // - não bate com outro agendamento do mesmo barbeiro.
  List<String> availableSlots() {
    final List<String> slots = [];
    final now = DateTime.now();
    int minutes = selectedBarber.startMinutes;

    while (minutes + selectedService.durationMinutes <=
        selectedBarber.endMinutes) {
      // DateTime aceita minutos acima de 59: (0h, 570min) vira 09:30.
      final start = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        0,
        minutes,
      );
      final end = start.add(Duration(minutes: selectedService.durationMinutes));

      if (start.isAfter(now) && !isBarberBusy(start, end)) {
        slots.add(Utils.hourFormat(start));
      }

      minutes = minutes + slotStepMinutes;
    }

    return slots;
  }

  bool isBarberBusy(DateTime start, DateTime end) {
    final barberAppointments = appointmentListController.appointmentsOfBarber(
      selectedBarber.id,
    );

    for (final appointment in barberAppointments) {
      if (appointment.status == AppointmentStatus.agendado) {
        final appointmentStart = appointment.dateTime;
        final appointmentEnd = appointmentStart.add(
          Duration(minutes: appointment.service.durationMinutes),
        );

        // Dois horários se chocam quando um começa antes do outro terminar.
        if (start.isBefore(appointmentEnd) && appointmentStart.isBefore(end)) {
          return true;
        }
      }
    }

    return false;
  }

  // Salva o agendamento na lista compartilhada e limpa o horário escolhido.
  // Devolve o agendamento criado (ou null se nenhum horário foi escolhido).
  Appointment? confirmAppointment() {
    final slot = selectedSlot;
    if (slot == null) {
      return null;
    }

    final appointment = appointmentListController.createAppointment(
      clientId: currentUserId,
      barber: selectedBarber,
      service: selectedService,
      dateTime: slotToDateTime(slot),
    );

    selectedSlot = null;
    notifyListeners();
    return appointment;
  }

  // '10:30' -> selectedDate às 10:30
  DateTime slotToDateTime(String slot) {
    final parts = slot.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
  }
}
