import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:bexmovil/src/presentation/views/global/code_create_meet.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//services
import '../../../../domain/models/meeting_data_source.dart';
import '../../../../domain/models/requests/event.dart';
import '../../../../locator.dart';
import '../../../../services/navigation.dart';
import '../../../widgets/custom_button_navigationbar.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CalendarPage extends StatefulWidget {
  final Eventos? event;

  const CalendarPage({Key? key, this.event}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  late GoogleAccountBloc googleaccountbloc;

  TextEditingController calendarcontroller = TextEditingController();

  GoogleAccountBloc calendarClient = GoogleAccountBloc();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController = CalendarController();
    googleaccountbloc = BlocProvider.of<GoogleAccountBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final events = BlocProvider.of<GoogleAccountBloc>(context).events;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    timeSlotViewSettings: TimeSlotViewSettings(
                        startHour: 9,
                        endHour: 16,
                        nonWorkingDays: <int>[
                          DateTime.friday,
                          DateTime.saturday
                        ]),
                    initialSelectedDate: DateTime.now(),
                    controller: calendarController,
                    dataSource:
                        MeetingDataSource(googleaccountbloc.appointments),
                    // appointmentBuilder: ,
                    selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.orange, width: 2),
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
              ],
            )
          ],
        ),
        floatingActionButton: CircleAvatar(
          backgroundColor: Colors.orange,
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  googleaccountbloc.createEvent();
                });
              },
              icon: const Icon(Icons.add)),
        ),
        bottomNavigationBar: const CustomButtonNavigationBar());
  }

  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(Meeting(
  //       'Conference 1', startTime, endTime, const Color(0xFF0F8644), false
  //       ),
  //     );
  //   meetings.add(Meeting(
  //       'Conference 2', startTime.add(Duration(hours: 3)), endTime.add(Duration(hours: 3)), const Color(0xFF0F8644), false
  //       ),
  //     );
  //   meetings.add(Meeting(
  //       'Conference 3', startTime, endTime, const Color(0xFF0F8644), false
  //       ),
  //     );
  //   return meetings;
  // }
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.from.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
