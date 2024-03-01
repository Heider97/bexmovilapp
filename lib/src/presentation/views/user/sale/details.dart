// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:bexmovil/src/presentation/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../locator.dart';
import '../../../../services/navigation.dart';
import '../../../../utils/constants/gaps.dart';

final NavigationService navigationService = locator<NavigationService>();

class DetailsSale extends StatefulWidget {
  List dataSales;
  DetailsSale({super.key, required this.dataSales});

  @override
  State<DetailsSale> createState() => _DetailsSaleState(data: dataSales);
}

class _DetailsSaleState extends State<DetailsSale> {
  List data;

  _DetailsSaleState({required this.data});

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
      Employee('IOST415D', 'Mora', '24/Ago/2022', 20000, "Other"),
      Employee('IOST415D', 'Mora', '24/Ago/2022', 30000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Mora', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 15000, "Other"),
      Employee('IOST415D', 'Al dia', '24/Ago/2022', 800, "Other")
    ];
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    int result = employees
        .map((item) => item.salary)
        .reduce((value, current) => value + current);
    final formatCurrency = NumberFormat.simpleCurrency();
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 38),
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
                        padding: const EdgeInsets.all(2), // Border width
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 119, 24),
                            borderRadius: borderRadius),
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 35),
                        ),
                      )),
                  Builder(builder: (context) {
                    return GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          padding: const EdgeInsets.all(2), // Border width
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 119, 24),
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
              Column(
                children: [
                  gapH44,
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: const Text("Comprador: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  gapH20,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Italcol", style: TextStyle(fontSize: 12)),
                      Text("Pedido No.20585557939",
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("San Antonio de Prado",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.zero,
                        alignment: Alignment.bottomRight,
                        child: const Row(
                          children: [
                            Text("Fecha: 18/12/2023",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                  gapH32,
                  SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 440,
                              child: SfDataGrid(
                                gridLinesVisibility: GridLinesVisibility.both,
                                source: employeeDataSource,
                                columnWidthMode: ColumnWidthMode.fill,
                                shrinkWrapRows: true,
                                columnWidthCalculationRange:
                                    ColumnWidthCalculationRange.allRows,
                                columns: <GridColumn>[
                                  GridColumn(
                                      columnName: 'product',
                                      label: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Producto',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'price',
                                      label: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          child: const Text('Precio',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  GridColumn(
                                      columnName: 'quantity',
                                      label: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          child: const Text('Cantidad',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  GridColumn(
                                      columnName: 'total',
                                      label: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          child: const Text('Total',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  gapH24,
                  Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                          "Gran Total: ${formatCurrency.format(result)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary, this.other);

  /// Id of an employee.
  final String id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;

  ///OTHER OF AN employee
  ///
  final String other;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'other', value: e.other),
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
      if (e.columnName == 'id') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(9.0),
          child: Text(
            e.value.toString(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        );
      }
      if (e.columnName == 'name') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(9.0),
          child: Text(
            e.value.toString(),
            style: TextStyle(
                fontSize: 15,
                color:
                    (e.value == 'Mora') ? Colors.red[700] : Colors.green[400]),
          ),
        );
      }

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(9.0),
        child: Text(
          e.value.toString(),
          style: const TextStyle(fontSize: 15),
        ),
      );
    }).toList());
  }
}
