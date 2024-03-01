import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/constants/gaps.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//cubit
import '../../../../cubits/home/home_cubit.dart';

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/user/stepper.dart';

//features
import '../widgets/card_router_sale.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class RoutersPage extends StatefulWidget {
  const RoutersPage({super.key});

  @override
  State<RoutersPage> createState() => _RoutersPageState();
}

late SaleStepperBloc saleStepperBloc;

class _RoutersPageState extends State<RoutersPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadRouters());
    saleStepperBloc = BlocProvider.of(context);
  }

  List<StepData> steps = [
    StepData(
        "Seleccionar \nCliente",
        'assets/icons/ProfileEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/ProfileDisable.png',
            () => saleStepperBloc.add(ChangeStepEvent(index: 0))),
    StepData(
        "Seleccionar \n Productos",
        'assets/icons/seleccionarFacturaEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/seleccionarFacturaDisable.png',
            () => saleStepperBloc.add(ChangeStepEvent(index: 1))),
    StepData(
        'Detalles de \n la orden',
        'assets/icons/actionEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/actionDisable.png',
            () => saleStepperBloc.add(ChangeStepEvent(index: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                        const AppBackButton(needPrimary: true),
                        AppIconButton(
                            onPressed: () =>
                                Scaffold.of(context).openDrawer(),
                            child: Icon(Icons.menu,
                                color:
                                theme.colorScheme.onPrimaryContainer)),
                      ],
                    ),
                    StepperWidget(currentStep: 0, steps: steps),
                    Padding(
                        padding: const EdgeInsets.all(Const.padding),
                        child: Container(
                          decoration: BoxDecoration(
                              color: theme.colorScheme.secondary,
                              borderRadius:
                              BorderRadius.circular(Const.space15)),
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
                                  style: TextStyle(
                                      color: theme.colorScheme.tertiary),
                                )
                              ],
                            ),
                          ),
                        )),
                    gapH4,
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
                    // BlocBuilder<SaleStepperBloc, SalesStepperState>(
                    //   builder: (context, state) {
                    //     if (state is SalesStepperClientSelection) {
                    //       return Row(
                    //         children: [
                    //           Expanded(
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: CustomSearchBar(
                    //                   prefixIcon: Icon(
                    //                     Icons.search,
                    //                     color: theme.primaryColor,
                    //                   ),
                    //                   controller: searchController,
                    //                   hintText: 'Nombre del cliente'),
                    //             ),
                    //           ),
                    //           const CustomFrameButtom(
                    //             icon: Icons.location_on,
                    //           ),
                    //           gapW12,
                    //           const CustomFrameButtom(
                    //             icon: Icons.tune,
                    //           )
                    //         ],
                    //       );
                    //     } else if (state is SalesStepperProductsSelection) {
                    //       return Row(
                    //         children: [
                    //           Expanded(
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: CustomSearchBar(
                    //                   prefixIcon: Icon(
                    //                     Icons.search,
                    //                     color: theme.primaryColor,
                    //                   ),
                    //                   controller: searchController,
                    //                   hintText:
                    //                   'Nombre o código del producto'),
                    //             ),
                    //           ),
                    //           const CustomFrameButtom(
                    //             icon: Icons.location_on,
                    //           ),
                    //           gapW12,
                    //           const CustomFrameButtom(
                    //             icon: Icons.tune,
                    //           )
                    //         ],
                    //       );
                    //     } else {
                    //       return Container();
                    //     }
                    //   },
                    // ),
                    // BlocBuilder<SaleStepperBloc, SalesStepperState>(
                    //   builder: (context, state) {
                    //     if (state is SalesStepperClientSelection) {
                    //       return Expanded(
                    //         child: Column(
                    //           mainAxisSize: MainAxisSize.max,
                    //           children: [
                    //             Expanded(
                    //                 child: ListView.builder(
                    //                   itemCount: clientes.length,
                    //                   itemBuilder: (context, index) {
                    //                     return Padding(
                    //                       padding: const EdgeInsets.all(8.0),
                    //                       child: ClientCard(
                    //                           client: clientes[index]),
                    //                     );
                    //                   },
                    //                 )),
                    //             gapH8,
                    //             BlocBuilder<SaleBloc, SaleState>(
                    //               builder: (context, saleState) {
                    //                 if (saleState is SaleClienteSelected) {
                    //                   return CustomElevatedButton(
                    //                     width: double.infinity,
                    //                     height: 50,
                    //                     onTap: () {
                    //                       saleStepperBloc.add(
                    //                           ChangeStepEvent(index: 1));
                    //                       /*  navigationService
                    //                               .goTo(Routes.detailSaleRoute); */
                    //                     },
                    //                     child: Text(
                    //                       'Siguiente',
                    //                       style: theme.textTheme.bodyLarge!
                    //                           .copyWith(
                    //                           fontWeight:
                    //                           FontWeight.bold,
                    //                           color: Colors.white),
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   return Container();
                    //                 }
                    //               },
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     } else if (state is SalesStepperProductsSelection) {
                    //       return Expanded(
                    //         child: Column(
                    //           children: [
                    //             Expanded(
                    //               child: ListView.builder(
                    //                 scrollDirection: Axis.vertical,
                    //                 itemCount: products.length,
                    //                 itemBuilder: (BuildContext context,
                    //                     int index) =>
                    //                     Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             right: 9, bottom: 10),
                    //                         child: ProductCard(
                    //                           product: products[index],
                    //                           refresh: _refresh,
                    //                         )),
                    //               ),
                    //             ),
                    //             (products.any(
                    //                     (product) => product.quantity > 0))
                    //                 ? CustomElevatedButton(
                    //               width: double.infinity,
                    //               height: 50,
                    //               onTap: () {
                    //                 saleStepperBloc.add(
                    //                     ChangeStepEvent(index: 2));
                    //                 /* navigationService
                    //                               .goTo(Routes.detailSaleRoute); */
                    //               },
                    //               child: Text(
                    //                 'Siguiente',
                    //                 style: theme.textTheme.bodyLarge!
                    //                     .copyWith(
                    //                     fontWeight:
                    //                     FontWeight.bold,
                    //                     color: Colors.white),
                    //               ),
                    //             )
                    //                 : Container()
                    //           ],
                    //         ),
                    //       );
                    //     } else if (state is SalesStepperOrderDetails) {
                    //       return Expanded(
                    //         child: Column(
                    //           children: [
                    //             gapH44,
                    //             Container(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: const Text("Comprador: ",
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 16))),
                    //             gapH20,
                    //             const Row(
                    //               mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text("Italcol",
                    //                     style: TextStyle(fontSize: 12)),
                    //                 Text("Pedido No.20585557939",
                    //                     style: TextStyle(fontSize: 12)),
                    //               ],
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Container(
                    //                   alignment: Alignment.bottomLeft,
                    //                   child: const Row(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.start,
                    //                     children: [
                    //                       Text("San Antonio de Prado",
                    //                           style:
                    //                           TextStyle(fontSize: 12)),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   margin: EdgeInsets.zero,
                    //                   alignment: Alignment.bottomRight,
                    //                   child: const Row(
                    //                     children: [
                    //                       Text("Fecha: 18/12/2023",
                    //                           style:
                    //                           TextStyle(fontSize: 12)),
                    //                     ],
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             gapH32,
                    //             SingleChildScrollView(
                    //               child: SizedBox(
                    //                 width:
                    //                 MediaQuery.of(context).size.width,
                    //                 child: LayoutBuilder(
                    //                     builder: (context, constraints) {
                    //                       return Column(
                    //                         children: [
                    //                           SizedBox(
                    //                             height: 440,
                    //                             child: SfDataGrid(
                    //                               gridLinesVisibility:
                    //                               GridLinesVisibility.both,
                    //                               source: employeeDataSource,
                    //                               columnWidthMode:
                    //                               ColumnWidthMode.fill,
                    //                               shrinkWrapRows: true,
                    //                               columnWidthCalculationRange:
                    //                               ColumnWidthCalculationRange
                    //                                   .allRows,
                    //                               columns: <GridColumn>[
                    //                                 GridColumn(
                    //                                     columnName: 'product',
                    //                                     label: Container(
                    //                                         padding:
                    //                                         const EdgeInsets
                    //                                             .all(10.0),
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         child: const Text(
                    //                                           'Producto',
                    //                                           style: TextStyle(
                    //                                               fontSize: 11,
                    //                                               fontWeight:
                    //                                               FontWeight
                    //                                                   .bold),
                    //                                         ))),
                    //                                 GridColumn(
                    //                                     columnName: 'price',
                    //                                     label: Container(
                    //                                         padding:
                    //                                         const EdgeInsets
                    //                                             .all(10.0),
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         child: const Text(
                    //                                             'Precio',
                    //                                             style: TextStyle(
                    //                                                 fontSize:
                    //                                                 11,
                    //                                                 fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold)))),
                    //                                 GridColumn(
                    //                                     columnName: 'quantity',
                    //                                     label: Container(
                    //                                         padding:
                    //                                         const EdgeInsets
                    //                                             .all(10.0),
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         child: const Text(
                    //                                             'Cantidad',
                    //                                             style: TextStyle(
                    //                                                 fontSize:
                    //                                                 11,
                    //                                                 fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold)))),
                    //                                 GridColumn(
                    //                                     columnName: 'total',
                    //                                     label: Container(
                    //                                         padding:
                    //                                         const EdgeInsets
                    //                                             .all(10.0),
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         child: const Text(
                    //                                             'Total',
                    //                                             style: TextStyle(
                    //                                                 fontSize:
                    //                                                 11,
                    //                                                 fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold)))),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       );
                    //                     }),
                    //               ),
                    //             ),
                    //             gapH24,
                    //             Container(
                    //                 alignment: Alignment.bottomRight,
                    //                 child: Text(
                    //                     "Gran Total: ${formatCurrency.format(564456)}",
                    //                     style: const TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 16))),
                    //           ],
                    //         ),
                    //       );
                    //     } else {
                    //       return const Expanded(
                    //         child: Center(child: Text('404 Not found')),
                    //       );
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}