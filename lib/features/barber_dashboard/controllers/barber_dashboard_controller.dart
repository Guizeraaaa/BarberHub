import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:barberhub/shared/models/appointment.dart';
import 'package:flutter/material.dart';

class BarberDashboardController extends ChangeNotifier {
  BarberDashboardController(
    this.appointmentListController,
    this.loginController,
  );

  final AppointmentListController appointmentListController;
  final LoginController loginController;

  String get barberName => loginController.currentBarber?.name ?? '';

  List<Appointment> get myAppointments {
    final barber = loginController.currentBarber;
    if (barber == null) {
      return [];
    }
    return appointmentListController.appointmentsOfBarber(barber.id);
  }

  int get todayCount {
    final today = DateUtils.dateOnly(DateTime.now());
    return myAppointments.where((item) {
      return item.status == AppointmentStatus.agendado &&
          DateUtils.isSameDay(item.dateTime, today);
    }).length;
  }

  double get monthRevenue {
    final now = DateTime.now();
    double total = 0;
    for (final item in myAppointments) {
      if (item.status == AppointmentStatus.concluido &&
          item.dateTime.year == now.year &&
          item.dateTime.month == now.month) {
        total = total + item.service.price;
      }
    }
    return total;
  }

  int countByStatus(AppointmentStatus status) {
    return myAppointments.where((item) => item.status == status).length;
  }

  Map<String, int> get countByService {
    final Map<String, int> result = {};
    for (final item in myAppointments) {
      if (item.status == AppointmentStatus.cancelado) {
        continue;
      }
      final name = item.service.name;
      result[name] = (result[name] ?? 0) + 1;
    }
    return result;
  }
}
