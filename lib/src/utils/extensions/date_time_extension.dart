extension DateUtil on DateTime {
  String get formatted {
    return "$year-$month-$day";
  }

  String formatTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}';
  }
}
