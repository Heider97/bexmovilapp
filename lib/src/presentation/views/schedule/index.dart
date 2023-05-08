import 'dart:math';
import 'package:flutter/material.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  var day = 21;

  var hour = 1;

  var days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  int selectedIndex = 0;

  IconData getRandomIcon() {
    final Random random = Random();
    const String chars = '0123456789ABCDEF';
    int length = 3;
    String hex = '0xe';
    while (length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('February'),
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
          itemBuilder: (context, index) => SizedBox(
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
                      Theme.of(context).colorScheme.primaryContainer,
                  title: Text(days[index], textAlign: TextAlign.center),
                  subtitle: Text((day + index).toString(),
                      textAlign: TextAlign.center),
                ),
              )),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(12)),
                        height: 50,
                        width: 50,
                        child: Icon(getRandomIcon()),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Flexible(
                            child: Text('Jogging in the morning',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Flexible(
                            child: Text('- Inviting bex soluciones',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300))),
                        Flexible(
                            child: Text('- Bring a bottle of mineral water',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 11,
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
          itemCount: 12,
          itemBuilder: (context, index) => ListTile(
                selected: index == selectedIndex,
                title: Text('${hour + index}:00', textAlign: TextAlign.center),
              )),
    );
  }
}
