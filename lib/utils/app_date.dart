// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class AppDate {
  static String generateTimeString() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm");
    var dateTime = formatter.format(now);
    var offset = now.timeZoneOffset;
    var utcHourOffset = (offset.isNegative ? '-' : '+') +
        offset.inHours.abs().toString().padLeft(2, '0');
    var utcMinuteOffset =
        (offset.inMinutes - offset.inHours * 60).toString().padLeft(2, '0');
    var timeString = '$dateTime$utcHourOffset:$utcMinuteOffset';
    return timeString;
  }

  // if you want to parse that date again to the original DateTime object
  static DateTime parseTimeStringToDateTime(String timeString) {
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm");
    var dateTime = formatter.parse(timeString.substring(0, 16));
    return dateTime;
  }
}
