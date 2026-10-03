import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

class SchedulingController extends ChangeNotifier {
  SchedulingController(this.appointmentListController);

  final AppointmentListController appointmentListController;

  Client currentClient = mockClients[1];

  final int slotStepMinutes = 30;

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

  List<Barber> barbersForSelectedService() {
    return barbersList
        .where(
          (barber) => barber.offeredService.any(
            (service) => service.id == selectedService.id,
          ),
        )
        .toList();
  }

  void selectService(Service service) {
    selectedService = service;

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

  List<String> availableSlots() {
    final List<String> slots = [];
    final now = DateTime.now();
    int minutes = selectedBarber.startMinutes;

    while (minutes + selectedService.durationMinutes <=
        selectedBarber.endMinutes) {
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

        if (start.isBefore(appointmentEnd) && appointmentStart.isBefore(end)) {
          return true;
        }
      }
    }

    return false;
  }

  Appointment? confirmAppointment() {
    final slot = selectedSlot;
    if (slot == null) {
      return null;
    }

    final appointment = appointmentListController.createAppointment(
      client: currentClient,
      barber: selectedBarber,
      service: selectedService,
      dateTime: slotToDateTime(slot),
    );

    selectedSlot = null;
    notifyListeners();
    return appointment;
  }

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
