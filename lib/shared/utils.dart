import 'package:barberhub/shared/models/Appointment.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(double valor) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(valor);
  }

  static String dateFormat(DateTime date) {
    return DateFormat('dd/MM/yy').format(date);
  }

  static String hourFormat(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String durationFormat(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) {
      return '$minutes ${minutes == 1 ? 'minuto' : 'minutos'}';
    }

    if (remainingMinutes == 0) {
      return '$hours ${hours == 1 ? 'hora' : 'horas'}';
    }

    return '$hours ${hours == 1 ? 'hora' : 'horas'} e '
        '$remainingMinutes ${remainingMinutes == 1 ? 'minuto' : 'minutos'}';
  }

  static String formatAppointmentStatus(AppointmentStatus status) {
    return switch (status) {
      AppointmentStatus.agendado => 'Agendado',
      AppointmentStatus.cancelado => 'Cancelado',
      AppointmentStatus.concluido => 'Finalizado',
    };
  }
}
