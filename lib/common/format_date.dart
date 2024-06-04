import 'package:intl/intl.dart';

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  } catch (e) {
    return date;
  }
}
