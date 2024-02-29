
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale_stepper/sale_stepper_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/sales/card_router_sale.dart';

import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../../locator.dart';
import '../../../../utils/constants/strings.dart';
import '../../../cubits/home/home_cubit.dart';


final NavigationService navigationService = locator<NavigationService>();

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _SalePageState();
}

late SaleStepperBloc saleStepperBloc;

class _SalePageState extends State<RouterPage> {
  final TextEditingController searchController = TextEditingController();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadRouters());
  }

  _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    BorderRadius borderRadius = BorderRadius.circular(Const.radius);

    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(Const.space15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  navigationService.goBack();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(2), // Border width
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: borderRadius),
                                  child: ClipRRect(
                                    borderRadius: borderRadius,
                                    child: const Icon(Icons.keyboard_arrow_left_rounded,
                                        color: Colors.white, size: 35),
                                  ),
                                )),
                            Builder(builder: (context) {
                              return GestureDetector(
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(2), // Border width
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: borderRadius),
                                    child: ClipRRect(
                                      borderRadius: borderRadius,
                                      child: const Icon(Icons.list,
                                          color: Colors.white, size: 35),
                                    ),
                                  ));
                            })
                          ],
                        ),
                        gapH16,
                        Padding(
                          padding: const EdgeInsets.all(Const.padding),
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(Const.space15)),
                            child: Padding(
                              padding: const EdgeInsets.all(Const.padding),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                  gapW24,
                                  Text(
                                    'Búsqueda por nombre rutero',
                                    style: TextStyle(color: theme.colorScheme.tertiary),
                                  )
                                ],
                              ),
                            ),
                          )),                      
                        gapH24,
                        BlocBuilder<SaleBloc, SaleState>(
                            builder: (context, state) {
                          if (state is SaleInitial) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: state.routers.length,
                                  itemBuilder: (context, index) {
                                    return CardRouter(
                                      quantityClients: state
                                            .routers[index].quantityClient
                                            .toString(),
                                        dayRouter: state
                                            .routers[index].nameDayRouter
                                            .toString());
                                  }),
                            );
                          } else {
                            return const Center(child: Text('Cargando'));
                          }
                        }),
                        
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}

