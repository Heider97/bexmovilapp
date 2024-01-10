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

    if(widget.event == null ){
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
                    const SizedBox(height: 40,),
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
                                hintStyle: TextStyle(color: theme.colorScheme.tertiary),
                                prefixIcon: Icon(Icons.search, color: theme.colorScheme.error,),
                                filled: true,
                                fillColor: theme.colorScheme.secondary,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)
                                )
                              ),
                            )
                          ),
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
                          
                            final event = details.appointments!.firstOrNull;
                          
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CodeCreateMeet(event: event)  
                            ));
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
                          
                          onLongPress: (details){
                            final provider = BlocProvider.of<GoogleAccountBloc>(context, listen: false);
                          
                            provider.setState(details.date!);
                          },
                          controller: calendarController,
                          dataSource:MeetingDataSource(events),
                          initialDisplayDate: googleaccountbloc.selectedDate,
                          appointmentBuilder: appointmentBuilder,
                          selectionDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: theme.colorScheme.primary, width: 2),
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
                              showAgenda: true
                          ),
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
          onPressed: (){
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
              ],
            ),
          );
        },
      );
      // Navigator.of(context).pop();
    }
  ),
        bottomNavigationBar: const CustomButtonNavigationBar(),
  );
}

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,
){
  final event = details.appointments.first;

  return Container(
    height: details.bounds.height,
    width: details.bounds.width,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12)
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10,),
              Text(
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 140, height: 55,),

              IconButton(
                onPressed: (){
                  setState(() {
                    final google = BlocProvider.of<GoogleAccountBloc>(context, listen: false);
                    google.deleteEvent(event);
                  });
                }, 
                icon: const Icon(Icons.delete, color: Colors.white,)
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10,),
              Text(
                GoogleAccountBloc.toTime(fromDate),
                // event.from.toString(), 
                style: const TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
}

