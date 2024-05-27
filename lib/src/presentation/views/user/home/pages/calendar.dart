import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return SafeArea(
        child: SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SfCalendar(
          onTap: (details) {
            if (details.appointments == null) return;

            final event = details.appointments!.firstOrNull;

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         CodeCreateMeet(event: event)));
          },
          // view: CalendarView.month,
          showDatePickerButton: true,
          timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 9,
              endHour: 16,
              nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),

          initialSelectedDate: DateTime.now(),
          headerHeight: 0,

          // onLongPress: (details) {
          //   final provider =
          //       BlocProvider.of<GoogleAccountBloc>(context, listen: false);
          //
          //   provider.setState(details.date!);
          // },
          // controller: calendarController,
          // dataSource: MeetingDataSource(events),
          // initialDisplayDate: googleaccountbloc.selectedDate,
          // appointmentBuilder: appointmentBuilder,
          selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: theme.colorScheme.primary, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              shape: BoxShape.rectangle),

          blackoutDates: [
            DateTime.now().subtract(const Duration(hours: 48)),
            DateTime.now().subtract(const Duration(hours: 24))
          ],

          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              showAgenda: true),
        ),
      ),
    ));
  }
}
