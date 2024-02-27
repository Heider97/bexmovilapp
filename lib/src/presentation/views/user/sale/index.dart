import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale_stepper/sale_stepper_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_frame_button.dart';
import 'package:bexmovil/src/presentation/widgets/sales/card_router_sale.dart';
import 'package:bexmovil/src/presentation/widgets/user/client_card.dart';

import 'package:bexmovil/src/presentation/widgets/user/product_card.dart';

import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//cubit
import '../../../../locator.dart';
import '../../../../utils/constants/strings.dart';
import '../../../cubits/home/home_cubit.dart';
import '../../../widgets/global/custom_elevated_button.dart';

import '../../../widgets/user/custom_search_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final NavigationService navigationService = locator<NavigationService>();

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

late SaleStepperBloc saleStepperBloc;

class _SalePageState extends State<SalePage> {
  final TextEditingController searchController = TextEditingController();
  final Map<Product, int> selectedQuantities = {};

  final formatCurrency = NumberFormat.simpleCurrency();

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);

    saleBloc.add(LoadRouters());

    saleStepperBloc = BlocProvider.of(context);

    employeeDataSource = EmployeeDataSource(employeeData: employees);
    employees = getEmployeeData();
  }

  _refresh() {
    setState(() {});
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          10001, 'James', 'Cerdo levante y engorde  Preiniciador', 20000, ''),
      Employee(10002, 'Kathryn', 'Cerdito Preiniciador', 30000, ''),
      Employee(
          10003, 'Lara', 'Cerdo levante y engorde  Preiniciador', 15000, ''),
      Employee(
          10004, 'Michael', 'Cerdo levante y engorde  Preiniciador', 15000, ''),
      Employee(
          10005, 'Martin', 'Cerdo levante y engorde  Preiniciador', 15000, ''),
      Employee(10006, 'Newberry', 'Cerdo levante y engorde  Preiniciador',
          15000, ''),
      Employee(10007, 'Balnc', 'Developer', 15000, ''),
      Employee(10008, 'Perry', 'Developer', 15000, ''),
      Employee(10009, 'Gable', 'Developer', 15000, ''),
      Employee(10010, 'Grimes', 'Developer', 15000, '')
    ];
  }

  List<Client> clientes = [
    Client(
      name: "Juan Garcia",
      email: "juan@example.com",
      dirCliente: "Calle 123, Ciudad",
      telCliente: "+123456789",
      isBooked: true,
      nitCliente: "123456-7",
      nomCliente: "Empresa XYZ",
      estadoCliente: "Activo",
      startTimeOfMeeting:
          DateTime(2024, 1, 29, 9, 0), // 29 de enero de 2024, 9:00 AM
      endTimeOfMeeting:
          DateTime(2024, 1, 29, 11, 0), // 29 de enero de 2024, 11:00 AM
      lastVisited:
          DateTime(2024, 1, 25), // Última visita el 25 de enero de 2024
      averageSales: "\$5000000000000000000000000",
      salesEffectiveness: "Altoooo oooooooooooooooooooooooooooooooooo",
    ),
    Client(
      name: "Pepito Perez",
      email: "juan@example.com",
      dirCliente: "Calle 123, Ciudad",
      telCliente: "+123456789",
      isBooked: true,
      nitCliente: "123456-7",
      nomCliente: "Empresa XYZ",
      estadoCliente: "Activo",
      startTimeOfMeeting:
          DateTime(2024, 1, 29, 9, 0), // 29 de enero de 2024, 9:00 AM
      endTimeOfMeeting:
          DateTime(2024, 1, 29, 11, 0), // 29 de enero de 2024, 11:00 AM
      lastVisited:
          DateTime(2024, 1, 25), // Última visita el 25 de enero de 2024
      averageSales: "\$5000000000000000000000000",
      salesEffectiveness: "Altoooo oooooooooooooooooooooooooooooooooo",
    ),
    Client(
      name: "Jairo Grande",
      email: "juan@example.com",
      dirCliente: "Calle 123, Ciudad",
      telCliente: "+123456789",
      isBooked: true,
      nitCliente: "123456-7",
      nomCliente: "Empresa XYZ",
      estadoCliente: "Activo",
      startTimeOfMeeting:
          DateTime(2024, 1, 29, 9, 0), // 29 de enero de 2024, 9:00 AM
      endTimeOfMeeting:
          DateTime(2024, 1, 29, 11, 0), // 29 de enero de 2024, 11:00 AM
      lastVisited:
          DateTime(2024, 1, 25), // Última visita el 25 de enero de 2024
      averageSales: "\$5000000000000000000000000",
      salesEffectiveness: "Altoooo oooooooooooooooooooooooooooooooooo",
    )
  ];

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
                                    child: const Icon(Icons.close,
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
                        StepperWidget(currentStep: 0, steps: steps),
                        gapH4,
                        // BlocBuilder<SaleBloc, SaleState>(
                        //     builder: (context, state) {
                        //   if (state is SaleInitial) {
                        //     return Expanded(
                        //       child: ListView.builder(
                        //           itemCount: state.routers.length,
                        //           itemBuilder: (context, index) {
                        //             return CardRouter(
                        //               quantityClients: state
                        //                     .routers[index].quantityClient
                        //                     .toString(),
                        //                 priceList: state
                        //                     .routers[index].price
                        //                     .toString(),
                        //                 dayRouter: state
                        //                     .routers[index].dayRouter
                        //                     .toString());
                        //           }),
                        //     );
                        //   } else {
                        //     return const Center(child: Text('Cargando'));
                        //   }
                        // }),
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

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary, this.action);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;

  /// Salary of an employee.
  final String action;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'actions', value: e.action),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.columnName == "actions"
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(9.0),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            )
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(9.0),
              child: Text(
                e.value.toString(),
                style: const TextStyle(fontSize: 9),
              ),
            );
    }).toList());
  }
}
