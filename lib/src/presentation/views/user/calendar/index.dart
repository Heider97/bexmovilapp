import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:bexmovil/src/presentation/views/global/code_create_meet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//services
import '../../../../domain/models/meeting.dart';
import '../../../../domain/models/meeting_data_source.dart';
import '../../../../domain/models/requests/event.dart';
import '../../../../locator.dart';
import '../../../../services/navigation.dart';
import '../../../widgets/custom_button_navigationbar.dart';
import '../../../widgets/global/custom_textformfield.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CalendarPage extends StatefulWidget {
  final Eventos? event;

  const CalendarPage({Key? key, this.event}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  late GoogleAccountBloc googleaccountbloc;

  late DateTime fromDate;

  TextEditingController calendarcontroller = TextEditingController();

  GoogleAccountBloc calendarClient = GoogleAccountBloc();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController = CalendarController();
    googleaccountbloc = BlocProvider.of<GoogleAccountBloc>(context);

    if (widget.event == null) {
      fromDate = DateTime.now();
    } else {
      final event = widget.event!;

      fromDate = event.from;
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final events = BlocProvider.of<GoogleAccountBloc>(context).events;

    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: theme.colorScheme.primary,
                            child: const Text('D'),
                          ),
                          SizedBox(
                              width: size.width / 1.3,
                              height: size.height * 0.1,
                              child: TextFormField(
                                controller: calendarcontroller,
                                decoration: InputDecoration(
                                    hintText: '¿ Que estas buscando ?',
                                    hintStyle: TextStyle(
                                        color: theme.colorScheme.tertiary),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: theme.colorScheme.error,
                                    ),
                                    filled: true,
                                    fillColor: theme.colorScheme.secondary,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(50))),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SfCalendar(
                          onTap: (details) {
                            if (details.appointments == null) return;

                            final event = details.appointments!.firstOrNull;

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CodeCreateMeet(event: event)));
                          },
                          view: CalendarView.month,
                          showDatePickerButton: true,
                          timeSlotViewSettings: const TimeSlotViewSettings(
                              startHour: 9,
                              endHour: 16,
                              nonWorkingDays: <int>[
                                DateTime.friday,
                                DateTime.saturday
                              ]),

                          initialSelectedDate: DateTime.now(),
                          headerHeight: 0,

                          onLongPress: (details) {
                            final provider = BlocProvider.of<GoogleAccountBloc>(
                                context,
                                listen: false);

                            provider.setState(details.date!);
                          },
                          controller: calendarController,
                          // dataSource: MeetingDataSource(events),
                          initialDisplayDate: googleaccountbloc.selectedDate,
                          // appointmentBuilder: appointmentBuilder,
                          selectionDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: theme.colorScheme.primary, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              shape: BoxShape.rectangle),

                          blackoutDates: [
                            DateTime.now().subtract(const Duration(hours: 48)),
                            DateTime.now().subtract(const Duration(hours: 24))
                          ],

                          monthViewSettings: const MonthViewSettings(
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.indicator,
                              showAgenda: true),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                shape: const LinearBorder(),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.orange,
                                  child: Text('D'),
                                ),
                                SizedBox(
                                    width: 230,
                                    child: CustomTextFormField(
                                        controller: calendarcontroller,
                                        hintText: '¿ Que estas buscando ?'))
                              ],
                            ),
                          ),
                          // const SizedBox(height: 20,),
                          SizedBox(
                            height: 500,
                            child: SfCalendar(
                              onTap: (calendarTapDetails) {
                                //agregando un evento por medio del ontap
                                setState(() {
                                  // googleaccountbloc.createEvent();
                                  // googleaccountbloc.close();
                                });
                              },
                              view: CalendarView.month,
                              showDatePickerButton: true,
                              allowViewNavigation: true,
                              timeSlotViewSettings: const TimeSlotViewSettings(
                                  startHour: 9,
                                  endHour: 16,
                                  nonWorkingDays: <int>[
                                    DateTime.friday,
                                    DateTime.saturday
                                  ]),
                              initialSelectedDate: DateTime.now(),
                              controller: calendarController,
                              // dataSource:
                              //     MeetingDataSource(googleaccountbloc.appointments),
                              // appointmentBuilder: ,
                              selectionDecoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  shape: BoxShape.rectangle),

                              blackoutDates: [
                                DateTime.now()
                                    .subtract(const Duration(hours: 48)),
                                DateTime.now()
                                    .subtract(const Duration(hours: 24))
                              ],

                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.indicator,
                                  showAgenda: true),
                            ),
                          ),
                        ],
                      ));
                });
          },
        ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime,
        const Color(0xFF0F8644), false, null));
    return meetings;
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
        height: details.bounds.height,
        width: details.bounds.width,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 140,
                    height: 55,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          final google = BlocProvider.of<GoogleAccountBloc>(
                              context,
                              listen: false);
                          google.deleteEvent(event);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    GoogleAccountBloc.toTime(fromDate),
                    // event.from.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
