import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:bexmovil/src/presentation/views/global/code_create_meet.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//services
import '../../../../domain/models/requests/event.dart';
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
  // TextEditingController _eventName = TextEditingController();
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController = CalendarController();
    googleaccountbloc = BlocProvider.of<GoogleAccountBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = BlocProvider.of<GoogleAccountBloc>(context).events;

    return Scaffold(
        body: SafeArea(
          child: Stack(
            
            children: [
              SingleChildScrollView(
                child: Column(
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
                            child: TextFormField(
                              controller: calendarcontroller,
                              decoration: InputDecoration(
                                hintText: '¿ Que estas buscando ?',
                                hintStyle: TextStyle(color: Colors.orange.shade300),
                                prefixIcon: const Icon(Icons.search, color: Color(0xFFf44336),),
                                filled: true,
                                fillColor: Colors.orange.shade50,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)
                                )
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                          
                    // const SizedBox(height: 20,),
                          
                    SizedBox(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SfCalendar(  
                          onTap: (details){
                            if(details.appointments == null) return;
                          
                            final event = details.appointments!.first;
                          
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CodeCreateMeet(event: event)  
                            ));
                          },
                          view: CalendarView.month,
                          // showDatePickerButton: true,
                          // allowViewNavigation: true,
                          timeSlotViewSettings: const TimeSlotViewSettings(
                              startHour: 9,
                              endHour: 16,
                              nonWorkingDays: <int>[
                                DateTime.friday,
                                DateTime.saturday
                              ]),
                          
                          initialSelectedDate: DateTime.now(),
                          headerHeight: 0,
                          
                          onLongPress: (details){
                            final provider = BlocProvider.of<GoogleAccountBloc>(context, listen: false);
                          
                            provider.setState(details.date!);
                          },
                          controller: calendarController,
                          dataSource:MeetingDataSource(events),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
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
                  title: const Text(
                    'Nueva Reunion',
                  ),
                  subtitle: const Text(
                    'Crea una nueva reunion de trabajo',
                  ),
                ),
                ListTile(
                  onTap: () {
                    // _navigationService.goTo(Routes.codeFormRequest);
                    // recoveryBloc
                    //     .add(const StartRecovery(type: 'SMS'));
                  },
                  title: const Text(
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
    ),
        bottomNavigationBar: const CustomButtonNavigationBar());
}

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
     

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
                  title: const Text(
                    'Nueva Reunion',
                  ),
                  subtitle: const Text(
                    'Crea una nueva reunion de trabajo',
                  ),
                ),
                ListTile(
                  onTap: () {
                    // _navigationService.goTo(Routes.codeFormRequest);
                    // recoveryBloc
                    //     .add(const StartRecovery(type: 'SMS'));
                  },
                  title: const Text(
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
  MeetingDataSource(List<Eventos> appointments) {
    this.appointments = appointments;
  }

  Eventos getEvent(int index) => appointments![index] as Eventos;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;

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
