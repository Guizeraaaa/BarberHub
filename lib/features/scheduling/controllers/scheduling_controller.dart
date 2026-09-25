import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

class SchedulingController extends ChangeNotifier {
  Service? selectedService;
  Barber? selectedBarber;
  DateTime selectedDate = DateTime.now();
  String? selectedSlot;

  // Intervalo entre um horário e outro na grade (09:00, 09:30, 10:00...)
  final int _slotInterval = 30;

  List<Service> get serviceList => mockServices;

  // Só mostra barbeiros que fazem o serviço escolhido
  List<Barber> get barberList {
    if (selectedService == null) {
      return mockBarbers;
    }
    return mockBarbers.where((barber) {
      return barber.offeredServiceIds.contains(selectedService!.id);
    }).toList();
  }

  // Botão CONFIRMAR só fica ativo com todos os campos preenchidos
  bool get canConfirm =>
      selectedService != null && selectedBarber != null && selectedSlot != null;

  // Data e horários só aparecem depois de escolher serviço e barbeiro
  bool get canShowSlots => selectedService != null && selectedBarber != null;

  // Limites do calendário: de hoje até daqui 30 dias
  // (começa à meia-noite de hoje para não dar erro no showDatePicker)
  DateTime get firstDate {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get lastDate => DateTime.now().add(const Duration(days: 30));

  // ---------- Textos dos cards ----------
  String get serviceTitle =>
      selectedService == null ? 'Escolha o serviço' : selectedService!.name;

  String get serviceSubtitle => selectedService == null
      ? 'Toque para selecionar'
      : serviceDescription(selectedService!);

  String get serviceInitial =>
      selectedService == null ? '?' : selectedService!.name[0];

  String get barberTitle =>
      selectedBarber == null ? 'Escolha o barbeiro' : selectedBarber!.name;

  String get barberSubtitle =>
      selectedBarber == null ? 'Toque para selecionar' : 'Barbeiro';

  String get barberInitial =>
      selectedBarber == null ? '?' : selectedBarber!.name[0];

  String get serviceActionLabel =>
      selectedService == null ? 'Escolher' : 'Alterar';

  String get barberActionLabel =>
      selectedBarber == null ? 'Escolher' : 'Alterar';

  // ---------- Rodapé ----------
  String get priceText => Utils.formatCurrency(selectedService?.price ?? 0);

  int? get durationMinutes => selectedService?.durationMinutes;

  // Ex: 'R$ 45,00 - 30 minutos'
  String serviceDescription(Service service) {
    return '${Utils.formatCurrency(service.price)} - '
        '${Utils.durationFormat(service.durationMinutes)}';
  }

  void selectService(Service service) {
    selectedService = service;

    // Se o barbeiro escolhido não faz esse serviço, limpa o barbeiro
    if (selectedBarber != null &&
        !selectedBarber!.offeredServiceIds.contains(service.id)) {
      selectedBarber = null;
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
    selectedDate = date;
    selectedSlot = null;
    notifyListeners();
  }

  void selectSlot(String slot) {
    selectedSlot = slot;
    notifyListeners();
  }

  // Monta a lista de horários livres do barbeiro no dia escolhido
  List<String> getAvailableSlots() {
    if (selectedService == null || selectedBarber == null) {
      return [];
    }

    List<String> slots = [];
    int minutes = selectedBarber!.startMinutes;

    // O serviço precisa terminar antes do fim do expediente
    while (minutes + selectedService!.durationMinutes <=
        selectedBarber!.endMinutes) {
      DateTime start = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        minutes ~/ 60,
        minutes % 60,
      );

      // Regra: não pode agendar no passado nem em horário ocupado
      if (start.isAfter(DateTime.now()) && !hasConflict(start)) {
        slots.add(Utils.hourFormat(start));
      }

      minutes += _slotInterval;
    }

    return slots;
  }

  // Regra 2: o mesmo barbeiro não pode ter dois agendamentos no mesmo horário
  bool hasConflict(DateTime start) {
    DateTime end = start.add(
      Duration(minutes: selectedService!.durationMinutes),
    );

    for (final appointment in mockAppointments) {
      if (appointment.barber.id != selectedBarber!.id) continue;
      if (appointment.status == AppointmentStatus.cancelado) continue;

      DateTime appointmentEnd = appointment.dateTime.add(
        Duration(minutes: appointment.service.durationMinutes),
      );

      // Um horário "encosta" no outro?
      if (start.isBefore(appointmentEnd) &&
          appointment.dateTime.isBefore(end)) {
        return true;
      }
    }

    return false;
  }

  // Transforma '10:30' + data escolhida em um DateTime
  DateTime _slotToDateTime(String slot) {
    List<String> parts = slot.split(':');
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  // Salva o agendamento na lista mockAppointments.
  // Retorna null se deu certo, ou a mensagem de erro para mostrar na tela.
  String? confirmAppointment(String? clientId) {
    if (clientId == null) {
      return 'Faça login para agendar';
    }

    if (!canConfirm) {
      return 'Preencha serviço, barbeiro e horário';
    }

    DateTime dateTime = _slotToDateTime(selectedSlot!);

    if (hasConflict(dateTime)) {
      return 'Esse horário não está mais disponível. Escolha outro.';
    }

    Appointment appointment = Appointment(
      id: 'a${DateTime.now().millisecondsSinceEpoch}',
      clientId: clientId,
      barber: selectedBarber!,
      service: selectedService!,
      dateTime: dateTime,
      status: AppointmentStatus.agendado,
    );

    mockAppointments.add(appointment);
    _clear();
    return null;
  }

  void _clear() {
    selectedService = null;
    selectedBarber = null;
    selectedDate = DateTime.now();
    selectedSlot = null;
    notifyListeners();
  }
}
