import 'package:intl/intl.dart';

class AppDateUtils {
  static String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat.yMMMd().format(date);
  }
}
