import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubits
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../blocs/gps/gps_bloc.dart';
import '../../../../cubits/home/home_cubit.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/styled_dialog_controller.dart';

//widgets
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/atoms/app_text.dart';

//features
import '../features/applications.dart';
import '../features/features.dart';
import '../features/statistics.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeCubit homeCubit;
  late GpsBloc gpsBloc;

  late TabController _tabController;

  final TextEditingController searchController = TextEditingController();
  List<Widget?>? kpiWalletList;

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    gpsBloc = BlocProvider.of<GpsBloc>(context);
    homeCubit.init();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final styledDialogController = locator<StyledDialogController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocConsumer<GpsBloc, GpsState>(listener: (context, state) {
      if (state.isGpsEnabled == true && state.showDialog == true) {
        styledDialogController.closeVisibleDialog();
      } else if (state.isGpsEnabled == false) {
        context.read<GpsBloc>().add(const GpsShowDisabled());
        styledDialogController.showDialogWithStyle(Status.error,
            closingFunction: () => Navigator.of(context).pop());
      }
    }, builder: (context, state) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(
                child: CupertinoActivityIndicator(color: Colors.red));
          } else {
            return _buildBody(size, theme, state, context);
          }
        },
      );
    });
  }

  Widget _buildBody(
      Size size, ThemeData theme, HomeState state, BuildContext context) {
    return SafeArea(
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
                      child: const Icon(Icons.menu, color: Colors.white)),
                  AppIconButton(
                      onPressed: () => homeCubit.sync(),
                      child: const Icon(Icons.sync, color: Colors.white)),
                  SizedBox(
                    width: size.width / 1.6,
                    height: size.height * 0.2,
                    child: GestureDetector(
                        onTap: () =>
                            homeCubit.navigationService.goTo(AppRoutes.chat),
                        child: Material(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            gapH8,
            AppText('Novedades', fontSize: 16),
            gapH8,
            const HomeFeatures(),
            gapH4,
            AppText('Estadisticas', fontSize: 16),
            gapH8,
            HomeStatistics(
                kpis: state.kpis ?? [],
                forms: const [],
                tabController: _tabController),
            gapH4,
            AppText('Mis Aplicaciones', fontSize: 16),
            gapH8,
            const HomeApplications(),
          ],
        ),
      ),
    );
  }
}
