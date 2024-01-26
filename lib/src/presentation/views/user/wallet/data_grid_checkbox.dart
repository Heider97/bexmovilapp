import 'package:bexmovil/src/presentation/views/user/sale/details_sale.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGridCheckBox extends StatefulWidget {
  DataGridCheckBox({super.key});

  @override
  State<DataGridCheckBox> createState() => _DataGridCheckBoxState();
}

class _DataGridCheckBoxState extends State<DataGridCheckBox> {
  final DataGridController _dataGridController = DataGridController();

  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employeeDataSource = EmployeeDataSource(employeeData: getEmployeeData());
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Cerdo levante y engorde  Preiniciador', 20000),
      Employee(10002, 'Kathryn', 'Cerdito Preiniciador', 30000),
      Employee(10003, 'Lara', 'Cerdo levante y engorde  Preiniciador', 15000),
      Employee(
          10004, 'Michael', 'Cerdo levante y engorde  Preiniciador', 15000),
      Employee(10005, 'Martin', 'Cerdo levante y engorde  Preiniciador', 15000),
      Employee(
          10006, 'Newberry', 'Cerdo levante y engorde  Preiniciador', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 80000)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      
      onCellTap: (details) {},
      columnWidthMode: ColumnWidthMode.none,
      isScrollbarAlwaysShown: true,
      horizontalScrollController: ScrollController(),
      source: employeeDataSource,
      showCheckboxColumn: true,
      allowFiltering: true,
      selectionMode: SelectionMode.multiple,
      controller: _dataGridController,
      columns: getColumns(),
    );
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
        // filterPopupMenuOptions: FilterPopupMenuOptions(),
        // allowFiltering: true,
        filterPopupMenuOptions: FilterPopupMenuOptions(
            filterMode: FilterMode.checkboxFilter,
            showColumnName: false,
            canShowClearFilterOption: false,
            canShowSortingOptions: false),
        columnName: 'id',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: const Text(
            'Factura',
            overflow: TextOverflow.clip,
          ),
        ),
      ),
      GridColumn(
        allowFiltering: true,
        columnName: 'Estado',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: const Text(
            'Estado',
            overflow: TextOverflow.clip,
          ),
        ),
      ),
      GridColumn(
        allowFiltering: true,
        columnName: 'Vencimiento',
        label: Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Vencimiento',
            overflow: TextOverflow.clip,
          ),
        ),
      ),
      GridColumn(
          allowFiltering: true,
          columnName: 'Valor',
          label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: const Text(
              'Valor',
              overflow: TextOverflow.clip,
            ),
          ),
          columnWidthMode: ColumnWidthMode.lastColumnFill),
    ];
    return columns;
  }
}
