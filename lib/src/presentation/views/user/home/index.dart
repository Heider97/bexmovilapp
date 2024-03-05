import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/gaps.dart';
import '../../../../utils/constants/strings.dart';

//widgets
import '../../../widgets/atoms/app_text.dart';
import '../../../widgets/drawer_widget.dart';

//features
import './features/features.dart';
import './features/statistics.dart';
import './features/applications.dart';

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
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else {
          return _buildBody(size, theme, state, context);
        }
      },
    );
  }

  Widget _buildBody(
      Size size, ThemeData theme, HomeState state, BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
          companyName: homeCubit.storageService.getString('company_name')),
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
                    AppIconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        child: state.user != null && state.user!.name != null
                            ? AppText(state.user!.name![0], color: Colors.white)
                            : AppText('B')),
                    AppIconButton(
                        onPressed: () => homeCubit.sync(),
                        child: const Icon(Icons.sync, color: Colors.white)),
                    SizedBox(
                      width: size.width / 1.6,
                      height: size.height * 0.2,
                      child: GestureDetector(
                          onTap: () => homeCubit.navigationService
                              .goTo(Routes.searchPage),
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
                                  Flexible(
                                      child: AppText('¿Qué estás buscando? ',
                                          fontSize: 13)),
                                  gapW20
                                ],
                              ))),
                    )
                  ],
                ),
              ),
              gapH20,
              HomeFeatures(features: state.features),
              gapH12,
              const Text("Estadísticas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              gapH4,
              HomeStatistics(
                  kpisOneLine: state.kpisOneLine ?? [],
                  kpisSlidableOneLine: state.kpisSlidableOneLine ?? [],
                  kpisSecondLine: state.kpisSecondLine ?? [],
                  kpisSlidableSecondLine: state.kpisSlidableSecondLine ?? [],
                  forms: [],
                  tabController: _tabController),
              gapH4,
              const Text('Tus aplicaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const HomeApplications(),
            ],
          ),
        ),
      ),
    );
  }
}
