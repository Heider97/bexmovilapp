import 'package:bexmovil/src/domain/models/kpi.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/gaps.dart';

//widgets
import '../../../widgets/user/custom_item.dart';

import '../../../widgets/custom_card_widget.dart';
import '../../../widgets/card_kpi.dart';
import '../../../widgets/card_reports.dart';
import '../../../widgets/drawer_widget.dart';

//services
import '../../../../locator.dart';

final NavigationService _navigationService = locator<NavigationService>();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeCubit homeCubit;
  late TabController _tabController;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.init();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => _buildBody(size, theme, state, context),
    );
  }

  Widget _buildBody(
      Size size, ThemeData theme, HomeState state, BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => homeCubit.logout(),
                        child: CircleAvatar(
                          radius: 25,
                          child: state.user != null && state.user!.name != null
                              ? Text(state.user!.name![0])
                              : const Text('U'),
                        )),
                    SizedBox(
                      width: size.width / 1.4,
                      height: size.height * 0.2,
                      child: GestureDetector(
                          onTap: () {
                            _navigationService.goTo(Routes.searchPage);
                          },
                          child: Material(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(50),
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  gapW20,
                                  Icon(
                                    Icons.search_outlined,
                                    color: theme.primaryColor,
                                  ),
                                  gapW20,
                                  const Expanded(
                                      child: Text('¿Qué estás buscando? ')),
                                  gapW20
                                ],
                              ))),
                    )
                  ],
                ),
              ),
              gapH20,
              SizedBox(
                  height: 120,
                  width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        state.features != null ? state.features!.length : 0,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomCard(
                          axis: Axis.horizontal,
                          text: state.features![index].descripcion!,
                          url: state.features![index].urldesc,
                          color: index / 2 == 0 ? Colors.orange : Colors.green),
                    ),
                  )),
              gapH12,
              const Text('Estadísticas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              gapH4,
              SizedBox(
                width: size.width,
                height: 280,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.values.first,
                      indicator: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.grey[100],
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'KPI',
                        ),
                        Tab(
                          text: 'Informes',
                        ),
                      ],
                    ),
                    gapH8,
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            height: 220,
                            width: 500,
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            CardKpi(
                                      tittle: 'Valor de las ventas',
                                      mainData: Kpi(
                                        title: 'Ventas parciales',
                                        percent: -5.2,
                                        value: 30,
                                      ),
                                      kpiData: [
                                        Kpi(
                                          title: 'Ventas pendientes.',
                                          percent: -0.1,
                                          value: 95,
                                        ),
                                        Kpi(
                                          title: 'Ventas totales',
                                          percent: 0.1,
                                          value: 80,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            CardKpi(
                                      tittle: 'Prospectos',
                                      mainData: Kpi(
                                        percent: 25.5,
                                        value: 80,
                                      ),
                                      kpiData: [
                                        Kpi(
                                          title: 'Prospectos creados.',
                                          percent: 10,
                                          value: 6,
                                        ),
                                        Kpi(
                                          title: 'Prospectos visitados',
                                          percent: 50,
                                          value: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                gapH12,
                                CardReports(
                                    iconCard: Icons.star_rate_rounded,
                                    urlIcon: "assets/svg/wallet-money.svg",
                                    tittle: "Mi\nPresupuesto",
                                    eventCard: () {}),
                                gapH12,
                                CardReports(
                                    iconCard: Icons.star_rate_rounded,
                                    urlIcon: "assets/svg/graphic.svg",
                                    tittle: "Mis\nestadísticas",
                                    eventCard: () {}),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              gapH4,
              const Text('Tus aplicaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomItem(
                          iconName: 'Vender',
                          imagePath: 'assets/svg/sell.svg',
                          onTap: () {
                            _navigationService.goTo(Routes.saleRoute);
                          }),
                      CustomItem(
                          iconName: 'Cartera',
                          imagePath: 'assets/svg/wallet.svg',
                          onTap: () {
                            _navigationService.goTo(Routes.wallet);
                          }),
                      CustomItem(
                          iconName: 'Mercadeo',
                          imagePath: 'assets/svg/mercadeo.svg',
                          onTap: () {
                            // _navigationService.goTo(Routes.mercadeo);
                          }),
                      CustomItem(
                          iconName: 'PQRS',
                          imagePath: 'assets/svg/pqrs.svg',
                          onTap: () {
                            // _navigationService.goTo(Routes.pqrs);
                          }),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomItem(
                          iconName: 'Vender',
                          imagePath: 'assets/svg/sell.svg',
                          onTap: () {
                            _navigationService.goTo(Routes.saleRoute);
                          }),
                      CustomItem(
                          iconName: 'Cartera',
                          imagePath: 'assets/svg/wallet.svg',
                          onTap: () {
                            _navigationService.goTo(Routes.wallet);
                          }),
                      CustomItem(
                          iconName: 'Mercadeo',
                          imagePath: 'assets/svg/mercadeo.svg',
                          onTap: () {
                            // _navigationService.goTo(Routes.mercadeo);
                          }),
                      CustomItem(
                          iconName: 'PQRS',
                          imagePath: 'assets/svg/pqrs.svg',
                          onTap: () {
                            // _navigationService.goTo(Routes.pqrs);
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
