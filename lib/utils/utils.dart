import 'package:intl/intl.dart';

String getDate(DateTime date) {
  return DateFormat.yMMMd('en_US').format(date);
}

String getTime(DateTime date) {
  return DateFormat.jm().format(date);
}

bool contactNameContainsText(String search, String name) {
  return name.toLowerCase().contains(search.toLowerCase());
}
