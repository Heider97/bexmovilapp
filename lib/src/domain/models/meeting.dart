import 'dart:ui';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.recurrenceRule);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? recurrenceRule;
}