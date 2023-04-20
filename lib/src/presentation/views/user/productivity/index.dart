import 'dart:math';
import 'package:BexMovil/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

//cubit
import '../../../cubits/productivity/productivity_cubit.dart';

//utils
import '../../../../utils/constants/nums.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/constants/extensions/color_extension.dart';

//features
import '../../../widgets/default_button_widget.dart';

//services
import '../../../../locator.dart';
import '../../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductivityView extends StatefulWidget {
  ProductivityView({Key? key}) : super(key: key);

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        AppColors.contentColorPink,
        AppColors.contentColorRed,
      ];

  final Color barBackgroundColor =
      AppColors.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = AppColors.contentColorWhite;
  final Color touchedBarColor = AppColors.contentColorGreen;

  @override
  State<ProductivityView> createState() => _ProductivityViewState();
}

class _ProductivityViewState extends State<ProductivityView> {
  late ProductivityCubit productivityCubit;

  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;
  final _random = Random();

  @override
  void initState() {
    productivityCubit = BlocProvider.of<ProductivityCubit>(context);
    productivityCubit.init();
    super.initState();
  }

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void dispose() {
    productivityCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: Builder(
          builder: (context) => CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => _navigationService.replaceTo(homeRoute),
              ),
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                child: Badge(
                  alignment: AlignmentDirectional.topEnd,
                  label: Text('2'),
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: null,
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProductivityCubit, ProductivityState>(
            bloc: productivityCubit,
            builder: (context, state) {
              if (state is ProductivityLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is ProductivitySuccess) {
                return buildProductivity(state);
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }

  Widget buildProductivity(state) {
    return BlocListener<ProductivityCubit, ProductivityState>(
        listener: (context, state) {},
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Productividad',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                      IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: null,
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Text(
                                  'Overall',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '41',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: BarChart(
                                      isPlaying ? randomData() : mainBarData(),
                                      swapAnimationDuration: animDuration,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    'planned',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    'completed',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              // child: IconButton(
                              //   icon: Icon(
                              //     isPlaying ? Icons.pause : Icons.play_arrow,
                              //     color: AppColors.contentColorGreen,
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       isPlaying = !isPlaying;
                              //       if (isPlaying) {
                              //         refreshState();
                              //       }
                              //     });
                              //   },
                              // ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Tareas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                      IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: null,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const CircleAvatar(
                                        radius: 20, child: Icon(Icons.done)),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Item $index'),
                                        Row(
                                          children: List.generate(
                                              next(1, 3),
                                              (index) => const CircleAvatar(
                                                    radius: 20,
                                                    child:
                                                        Icon(Icons.people_alt),
                                                  )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: DefaultButton(
                                widget: const Text('Añadir Subtarea', style: TextStyle(color: Colors.white, fontSize: 20)),
                                press: () {}),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex, barColor: Theme.of(context).colorScheme.primaryContainer);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mo', style: style);
        break;
      case 1:
        text = const Text('Tu', style: style);
        break;
      case 2:
        text = const Text('We', style: style);
        break;
      case 3:
        text = const Text('Th', style: style);
        break;
      case 4:
        text = const Text('Fr', style: style);
        break;
      case 5:
        text = const Text('Sa', style: style);
        break;
      case 6:
        text = const Text('Su', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: true),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
