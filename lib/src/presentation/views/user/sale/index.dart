import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/widgets/drawer_widget.dart';
import 'package:bexmovil/src/presentation/widgets/sales/card_product_sale.dart';
import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../../locator.dart';
import '../../../../utils/constants/strings.dart';
import '../../../cubits/home/home_cubit.dart';
import '../../../widgets/global/custom_elevated_button.dart';
import '../../../widgets/sales/card_client_sale.dart';
import '../../../widgets/user/custom_search_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../widgets/user/product_card.dart';

final NavigationService navigationService = locator<NavigationService>();

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  final TextEditingController searchController = TextEditingController();
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
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

  List<StepData> steps = [
    StepData("Seleccionar \nCliente", 'assets/icons/ProfileEnable.png',
        const Color(0xFFF4F4F4), 'assets/icons/ProfileDisable.png'),
    StepData(
        "Seleccionar \n Productos",
        'assets/icons/seleccionarFacturaEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/seleccionarFacturaDisable.png'),
    StepData('Detalles de \n la orden', 'assets/icons/realizarAccionEnable.png',
        const Color(0xFFF4F4F4), 'assets/icons/realizarAccionDisable.png'),
  ];

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
    final borderRadius = BorderRadius.circular(15);
    return Container(
      margin: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned(
            left: -size.width * 0.125,
            right: -size.width * 0.125,
            child: const Image(
                color: Colors.orangeAccent,
                image: AssetImage(
                  'assets/images/bg-prom-card.png',
                )),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: DrawerWidget(),
            body: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 16, left: 16, top: 38),
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
                                        color: const Color.fromARGB(
                                            255, 243, 119, 24),
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
                                      padding: const EdgeInsets.all(
                                          2), // Border width
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 243, 119, 24),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 260,
                                height: 50,
                                child: CustomSearchBar(
                                    controller: searchController,
                                    hintText: 'Nombre de la empresa'),
                              ),
                              GestureDetector(
                                onTap: () => '',
                                child: const CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(253, 241, 231, 1),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () => '',
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        10), // Border width
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 243, 119, 24),
                                        borderRadius: borderRadius),
                                    child: ClipRRect(
                                      borderRadius: borderRadius,
                                      child: const Icon(
                                          Icons.filter_alt_outlined,
                                          color: Colors.white,
                                          size: 20),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 450,
                            width: 500,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 10,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(right: 9),
                                            child: CardProductSale(
                                              birthPlace: "Medellin",
                                              code: "345345435",
                                              image:
                                                  "assets/images/super_pollito.png",
                                              lastQuantitySale: 90,
                                              quantityAvailable: 120,
                                              lastVisit: "29/Dic/2023",
                                              priceSale: 30000,
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          gapH8,
                          CustomElevatedButton(
                            width: 330,
                            height: 50,
                            onTap: () {
                              navigationService.goTo(Routes.detailSaleRoute);
                            },
                            child: Text(
                              'Siguiente',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 450,
                        width: 500,
                        child: Column(
                          children: [                                    
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      10,
                                  itemBuilder: (BuildContext context, int index) => Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: ProductCard(product: Product(
                                      lastSoldOn: DateTime.now(),
                                      lastQuantitySold: 5,
                                      code: 'XYZ789',
                                      name: 'Product 2',
                                      sellingPrice: 29.99,
                                      discount: 2.5,
                                      availableUnits: 50,
                                      quantity: 15,
                                      originLocation: OriginLocation(name: 'Product 2', availableQuantity: 20, isSelected: true),
                                    ),)
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                      gapH8,
                      CustomElevatedButton(
                        width: 330,
                        height: 50,
                        onTap: () => '',
                        child:
                              Text(
                                'Siguiente',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      )
                    ],
                  ),
                ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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
