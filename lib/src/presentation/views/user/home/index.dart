import 'package:bexmovil/src/presentation/widgets/global/custom_promotion_card.dart';
import 'package:bexmovil/src/presentation/widgets/user/my_search_delegate.dart';
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
import '../../../widgets/user/custom_search_bar.dart';
import '../../../widgets/custom_card_widget.dart';
//services
import '../../../../locator.dart';
import '../../../../services/storage.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
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
      builder: (context, state) => _buildBody(size, theme, state),
    );
  }

  Widget _buildBody(Size size, ThemeData theme, HomeState state) {
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
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
                                  Expanded(
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
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        state.features != null ? state.features!.length : 0,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: /*  CustomPromotionCard(
                          cardText: "Notification Test ",
                        ) */
                          CustomCard(
                              axis: Axis.horizontal,
                              text: state.features![index].descripcion!,
                              url: state.features![index].urldesc,
                              color: index / 2 == 0
                                  ? Colors.orange
                                  : Colors.green),
                    ),
                  )),
              gapH16,
              const Text('Estadisticas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              gapH16,
              SizedBox(
                width: size.width,
                height: 80,
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
                        children: [Container(), Container()],
                      ),
                    ),
                  ],
                ),
              ),
              gapH16,
              const Text('Tus aplicaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              gapH16,
              const Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomItem(
                            iconName: 'Vender',
                            imagePath: 'assets/icons/vender.png'),
                        CustomItem(
                            iconName: 'Cartera',
                            imagePath: 'assets/icons/cartera.png'),
                        CustomItem(
                            iconName: 'Mercadeo',
                            imagePath: 'assets/icons/mercadeo.png'),
                        CustomItem(
                            iconName: 'PQRS',
                            imagePath: 'assets/icons/pqrs.png')
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 170,
              //   width: size.width,
              //   child: const CustomNavbar(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
