import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//services
import '../../../../locator.dart';
import '../../../../services/navigation.dart';
import '../../../widgets/custom_button_navigationbar.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {

  late GoogleAccountBloc googleaccountbloc;

  TextEditingController calendarcontroller = TextEditingController();

  GoogleAccountBloc calendarClient = GoogleAccountBloc();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  CalendarController calendarController = CalendarController();
  

  @override
  void initState() {
    calendarController = CalendarController();
    googleaccountbloc = BlocProvider.of<GoogleAccountBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
                        hintText: '¿ Que estas buscando ?'
                      )
                    )
                  ],
                ),
              ),

              // const SizedBox(height: 20,),  

              SizedBox(
                height: 500,
                child: SfCalendar(
                  onTap: (calendarTapDetails) { //agregando un evento por medio del ontap
                    setState(() {
                      googleaccountbloc.createEvent();
                      // googleaccountbloc.close();
                    });
                  },
                    view: CalendarView.month,
                    initialSelectedDate: DateTime.now(),
                    controller: calendarController,
                    dataSource: MeetingDataSource(googleaccountbloc.appointments),
                    selectionDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle
                    ),
              
                    blackoutDates: [
                      DateTime.now().subtract(const Duration(hours: 48)),
                      DateTime.now().subtract(const Duration(hours: 24))
                    ],
                    
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                      showAgenda: true
                    ),
                  ),
              ),
              ],
            )
          ],
        ),
        floatingActionButton: IconButton(
          color: Colors.orange,
          onPressed: (){
            setState(() {
              googleaccountbloc.editEvent();
            });
          }, 
          icon: const Icon(Icons.edit)
        ),
        bottomNavigationBar: const CustomButtonNavigationBar()
      );
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

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
