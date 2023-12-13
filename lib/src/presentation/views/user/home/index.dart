import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/gaps.dart';
import '../../../../utils/constants/strings.dart';

//widgets
import '../../../widgets/user/custom_item.dart';
import '../../../widgets/user/custom_search_bar.dart';
import '../../../widgets/custom_card_widget.dart';
import '../../../widgets/card_kpi.dart';
import '../../../widgets/card_reports.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/user/custom_navbar.dart';
import '../../../widgets/user/my_search_delegate.dart';
//services
import '../../../../locator.dart';
import '../../../../services/storage.dart';
import '../../../../services/navigation.dart';

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
      builder: (context, state) => _buildBody(size, theme, state, context),
    );
  }


  Widget _buildBody(Size size, ThemeData theme, HomeState state, BuildContext context) {
    return Scaffold(
      drawer:  DrawerWidget(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: 65,
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
                      height: size.height / 1,
                      child: CustomSearchBar(
                          controller: searchController,
                          hintText: '¿Qué estás buscando?'),
                    ),
                    Builder(builder: (context){
                      return GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const SizedBox(
                          width: 35,
                          height: 45,
                          child: Icon(
                            Icons.list
                          ),
                        ),
                      );
                     }
                    )
                    
                  ],
                ),
              ),
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
                                      itemCount:
                                          10,
                                      itemBuilder: (BuildContext context, int index) => Padding(
                                        padding: const EdgeInsets.only(right: 9),
                                        child: CardKpi(iconCard: Icons.star_rate_rounded, urlIcon: "assets/icons/vender.png", tittle: "Ventas.", eventCard: (){}, quantity: 9,percentage: -20.5, valueCard: 1)
                                      ),
                                    ),
                                ),
                                
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          10,
                                      itemBuilder: (BuildContext context, int index) => Padding(
                                        padding: const EdgeInsets.only(right: 9),
                                        child: CardKpi(iconCard: Icons.star_rate_rounded, urlIcon: "assets/icons/vender.png", tittle: "Prospectos", eventCard: (){}, quantity: 80,percentage: 20.5, valueCard: 2)
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color:Colors.grey[100],
                            child: Column(
                              children: [
                                gapH12,
                                CardReports(iconCard: Icons.star_rate_rounded, urlIcon: "assets/icons/vender.png", tittle: "Mi\nPresupuesto", eventCard: (){}),
                                gapH12,
                                CardReports(iconCard: Icons.star_rate_rounded, urlIcon: "assets/icons/mercadeo.png", tittle: "Mis\nestadísticas", eventCard: (){}),
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
              SizedBox(
                height: 90,
                width: size.width,
                child: const Column(
                  children: [                              
                    Expanded(
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
                                  imagePath: 'assets/icons/pqrs.png'),
                            ],
                          ),                        
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              gapH8,
              /*Expanded(
                child:  SizedBox(
                   width: size.width,
                      height: size.height,
                  child: const CustomNavbar()
                  )
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

