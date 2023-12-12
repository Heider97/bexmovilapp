import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/presentation/widgets/global/error_alert_dialog.dart';
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
                              hintText: '¿ Que estas buscando ?'))
                    ],
                  ),
                ),

                // const SizedBox(height: 20,),

                SizedBox(
                  height: 500,
                  child: SfCalendar(  
                    onTap: calendarTapped,
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
        bottomNavigationBar: const CustomButtonNavigationBar());
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment meeting = details.appointments![0];

      showModalBottomSheet(
        shape: const LinearBorder(),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    //aqui va la otra vista para crear la nueva reunion
                    _navigationService.goTo(Routes.codecreatemeet);
                  },
                  title: Text(
                    'Nueva Reunion',
                  ),
                  subtitle: Text(
                    'Crea una nueva reunion de trabajo',
                  ),
                ),
                ListTile(
                  onTap: () {
                    _navigationService.goTo(Routes.codeFormRequest);
                    // recoveryBloc
                    //     .add(const StartRecovery(type: 'SMS'));
                  },
                  title: Text(
                    'Actualizar Reunion',
                  ),
                  subtitle: const Text(
                      'Actualiza tu reunion de trabajo si tienes algun imprevisto'),
                )
              ],
            ),
          );
        },
      );
    }
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

  @override
  String getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
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
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, this.recurrenceRule);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? recurrenceRule;
}
