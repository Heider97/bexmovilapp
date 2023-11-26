class Client {
  final DateTime? startTimeOfMeeting;
  final DateTime? endTimeOfMeeting;
  final double? averageSales;
  final bool? salesEffectiveness;
  final DateTime? lastVisited;
  final String name;
  final String? phone;
  final bool? isBooked;

  Client(
      {this.startTimeOfMeeting,
      this.endTimeOfMeeting,
      this.averageSales,
      this.salesEffectiveness,
      this.lastVisited,
      required this.name,
      this.phone,
      this.isBooked});
}
