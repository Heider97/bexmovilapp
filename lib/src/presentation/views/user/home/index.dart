import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';
import 'package:bexmovil/src/presentation/widgets/user/kpi_cards/wallet_kpi.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/gaps.dart';

//widgets
import '../../../widgets/user/custom_item.dart';

import '../../../widgets/custom_card_widget.dart';
import '../../../widgets/user/kpi_cards/card_kpi.dart';
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
  List<Widget?>? kpiWalletList;

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
    //LINE 1
    int length1line = 0;
    int amountWalletKpi1line = 0;
    List<Kpi> othersKpi1Line = [];

    //LINE 2
    int length2line = 0;
    int amountWalletKpi2line = 0;
    List<Kpi> othersKpi2Line = [];

    if (state.kpis != null) {
      //la longitud de la linea 1
      length1line = state.kpis!.where((kpi) => kpi.line == 1).toList().length;
      //wallet kpi line 1
      amountWalletKpi1line = state.kpis!
          .where((kpi) => kpi.line == 1 && kpi.type == 'wallet')
          .toList()
          .length;

      othersKpi1Line = state.kpis!
          .where((kpi) => kpi.type != 'wallet' && kpi.line == 1)
          .toList();

      if (amountWalletKpi1line != 0) {
        length1line = length1line - amountWalletKpi1line + 1;
      }

      //la longitud de la linea 2
      length2line = state.kpis!.where((kpi) => kpi.line == 2).toList().length;
      //wallet kpi line 2
      amountWalletKpi2line = state.kpis!
          .where((kpi) => kpi.line == 2 && kpi.type == 'wallet')
          .toList()
          .length;

      othersKpi2Line = state.kpis!
          .where((kpi) => kpi.type != 'wallet' && kpi.line == 2)
          .toList();

      if (amountWalletKpi2line != 0) {
        length2line = length2line - amountWalletKpi2line + 1;
      }
    }

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
                        onTap: () => Scaffold.of(context).openDrawer(),
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
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            width: Screens.width(context) / 2,
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: length1line,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (amountWalletKpi1line != 0 &&
                                            index == 0) {
                                          return SizedBox(
                                              width:
                                                  Screens.width(context) / 1.6,
                                              child: CarouselSlider(
                                                options: CarouselOptions(
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 4),
                                                  aspectRatio: 2,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  autoPlay: true,
                                                  viewportFraction: 1,
                                                ),
                                                items: (state.kpis != null)
                                                    ? state.kpis!
                                                        .where((kpi) =>
                                                            kpi.type ==
                                                                "wallet" &&
                                                            kpi.line == 1)
                                                        .map((kpi) =>
                                                            WalletKpi(kpi: kpi))
                                                        .toList()
                                                    : [],
                                              ));
                                        }

                                        if (index == 0) {
                                          return CardKpi(
                                              kpi: othersKpi1Line[index]);
                                        } else if (amountWalletKpi1line != 0) {
                                          return CardKpi(
                                              kpi: othersKpi1Line[index - 1]);
                                        } else {
                                          return CardKpi(
                                              kpi: othersKpi1Line[index]);
                                        }
                                      }),
                                ),
                                Expanded(
                                  //LINE 2 LIST
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: length2line,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (amountWalletKpi2line != 0 &&
                                            index == 0) {
                                          return SizedBox(
                                              width:
                                                  Screens.width(context) / 1.6,
                                              child: CarouselSlider(
                                                options: CarouselOptions(
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 4),
                                                  aspectRatio: 2,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  autoPlay: true,
                                                  viewportFraction: 1,
                                                ),
                                                items: (state.kpis != null)
                                                    ? state.kpis!
                                                        .where((kpi) =>
                                                            kpi.type ==
                                                                "wallet" &&
                                                            kpi.line == 2)
                                                        .map((kpi) =>
                                                            WalletKpi(kpi: kpi))
                                                        .toList()
                                                        .reversed
                                                        .toList()
                                                    : [],
                                              ));
                                        }

                                        if (index == 0) {
                                          return CardKpi(
                                              kpi: othersKpi2Line[index]);
                                        } else if (amountWalletKpi2line != 0) {
                                          return CardKpi(
                                              kpi: othersKpi2Line[index - 1]);
                                        } else {
                                          return CardKpi(
                                              kpi: othersKpi2Line[index]);
                                        }
                                      }),
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
                            _navigationService.goTo(Routes.walletprocess);
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
                      // CustomItem(
                      //     iconName: 'Vender',
                      //     imagePath: 'assets/svg/sell.svg',
                      //     onTap: () {
                      //       _navigationService.goTo(Routes.saleRoute);
                      //     }),
                      // CustomItem(
                      //     iconName: 'Cartera',
                      //     imagePath: 'assets/svg/wallet.svg',
                      //     onTap: () {
                      //       _navigationService.goTo(Routes.wallet);
                      //     }),
                      // CustomItem(
                      //     iconName: 'Mercadeo',
                      //     imagePath: 'assets/svg/mercadeo.svg',
                      //     onTap: () {
                      //       // _navigationService.goTo(Routes.mercadeo);
                      //     }),
                      // CustomItem(
                      //     iconName: 'PQRS',
                      //     imagePath: 'assets/svg/pqrs.svg',
                      //     onTap: () {
                      //       // _navigationService.goTo(Routes.pqrs);
                      //     }),
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
