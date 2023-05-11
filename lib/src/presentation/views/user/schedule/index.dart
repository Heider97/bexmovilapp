import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//cubit
import '../../../cubits/schedule/schedule_cubit.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {

  late ScheduleCubit scheduleCubit;

  final _currentDate = DateTime.now();
  final _hourFormatter = DateFormat('H');
  final _dayFormatter = DateFormat('E');
  final _numberDayFormatter = DateFormat('d');

  var months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  var days = [
    { 'Mon' : 'Lun' },
    { 'Tue' : 'Mar' },
    { 'Wed' : 'Mie' },
    { 'Thu' : 'Jue' },
    { 'Fri' : 'Vie' },
    { 'Sat' : 'Sab' },
    { 'Sun' : 'Dom' }
  ];

  int selectedIndex = 0;

  String returnMonth(DateTime date) {
    var currentMonth = date.month;
    return months[currentMonth-1];
  }

  @override
  void initState() {
    scheduleCubit = BlocProvider.of<ScheduleCubit>(context);
    scheduleCubit.init();
    super.initState();
  }

  @override
  void dispose() {
    scheduleCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => scheduleCubit.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(returnMonth(DateTime.now())),
        centerTitle: true,
        actions: [
          Builder(
              builder: (context) => const IconButton(
                  onPressed: null, icon: Icon(Icons.calendar_month)))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              itemsDays(size),
              Row(
                children: [itemsSection(size), hoursSection(size)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemsDays(Size size) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true, // Set this
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index){
              final date = _currentDate.add(Duration(days: index));
              final day = _dayFormatter.format(date);
              final number = _numberDayFormatter.format(date);

              final dayIndex = days.indexWhere((element) => element.keys.first == day);

              return SizedBox(
                  width: 80,
                  height: 80,
                  child: ListTile(
                    selected: index == selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tileColor: Colors.white,
                    selectedTileColor:
                    Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    title: Text(days[dayIndex].values.first, textAlign: TextAlign.center),
                    subtitle: Text(number.toString(),
                        textAlign: TextAlign.center),
                  )
              );
          }),
    );
  }

  Widget itemsSection(Size size) {
    return SizedBox(
      width: size.width * 0.7,
      height: size.height,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 7,
          itemBuilder: (context, index) => Container(
                width: 180,
                height: 160,
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                    title: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Flexible(
                          flex: 2,
                            child: Text('Reunion con cliente ',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Flexible(
                            child: Text('- Venta del nuevo producto',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300))),
                        Flexible(
                            child: Text('- Ofrecer el mejor precio posible',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300)))
                      ],
                    ),
                  ],
                )),
              )),
    );
  }

  Widget hoursSection(Size size) {
    return SizedBox(
      width: size.width * 0.3,
      height: size.height,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 24,
          itemBuilder: (context, index) {
            final date = index == 0 ? _currentDate : _currentDate.add(Duration(hours: index));
            final hour = _hourFormatter.format(date);
            return ListTile(
                title: Text('$hour:00', textAlign: TextAlign.center),
              );
          })
    );
  }
}
