import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(double valor) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(valor);
  }

  static String dateFormat(DateTime date) {
    return DateFormat('dd/MM/yy').format(date);
  }
}
