class Eventos {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;

  const Eventos({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.isAllDay = false
  });
}