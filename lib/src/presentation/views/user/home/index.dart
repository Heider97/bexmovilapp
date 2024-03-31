import 'package:bexmovil/src/presentation/views/user/home/features/dymamic_builder.dart';
import 'package:bexmovil/src/presentation/widgets/organisms/app_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../blocs/gps/gps_bloc.dart';

//cubits
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/gaps.dart';
import '../../../../utils/constants/strings.dart';

//widgets
import '../../../widgets/atoms/app_text.dart';
import '../../../widgets/atoms/app_icon_button.dart';

//features
import './features/features.dart';
import './features/statistics.dart';
import './features/applications.dart';

//services
import '../../../../locator.dart';
import '../../../../services/styled_dialog_controller.dart';

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
          if (state is HomeLoading) {
            return const Center(
                child: CupertinoActivityIndicator(color: Colors.green));
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
                            .goTo(AppRoutes.searchPage),
                        child: Material(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(50),
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
            ...state.sections != null
                ? state.sections!.map((e) => AppSection(
                    title: e.name!,
                    componentItems: const [],
                    tabController: _tabController))
                : [],
          ],
        ),
      ),
    );
  }
}
