import 'package:bexmovil/src/presentation/views/user/sale/details_sale.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class WalletDataGrid extends StatefulWidget {
  const WalletDataGrid({super.key});

  @override
  State<WalletDataGrid> createState() => _DataGridState();
}

class _DataGridState extends State<WalletDataGrid> {
  final DataGridController _dataGridController = DataGridController();

  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employeeDataSource = EmployeeDataSource(employeeData: getEmployeeData());
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
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            rowHeight: 50,
            frozenColumnsCount: 1,
            frozenRowsCount: 0,
            onSelectionChanged: (addedRows, removedRows) {
              for (var element in addedRows) {
                print('added: ${element.getCells().first.value}');
              }
              for (var element in removedRows) {
                print('removedRows: ${element.getCells().first.value}}');
              }
            },
            onCellTap: (details) {},
            isScrollbarAlwaysShown: true,
            horizontalScrollController: ScrollController(),
            source: employeeDataSource,
            // showCheckboxColumn: true,
            //  allowFiltering: true,
            selectionMode: SelectionMode.single,
            controller: _dataGridController,
            columns: getColumns(theme),
          ),
        ),
      ],
    );
  }

  List<GridColumn> getColumns(ThemeData theme) {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        columnName: 'id',
        minimumWidth: Screens.width(context) * 0.25,
        label: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: theme.primaryColor,
                  )),
              const Expanded(
                child: Text(
                  'Factura',
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        width: Screens.width(context) * 0.25,
        // allowFiltering: true,
        columnName: 'Estado',
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.filter_alt_outlined, color: theme.primaryColor)),
            const Expanded(
              child: Text(
                'Estado',
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
      GridColumn(
        minimumWidth: Screens.width(context) * 0.34,
        // allowFiltering: true,
        columnName: 'Vencimiento',

        label: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: theme.primaryColor,
                  )),
              const Expanded(
                child: Text(
                  'Vencimiento',
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
          // allowFiltering: true,
          minimumWidth: Screens.width(context) * 0.1,
          columnName: 'Valor',
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined,
                      color: theme.primaryColor)),
              const Expanded(
                child: Text(
                  'Valor',
                ),
              ),
            ],
          ),
          columnWidthMode: ColumnWidthMode.lastColumnFill),
      GridColumn(
          //  allowFiltering: true,
          columnName: 'Other',
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined,
                      color: theme.primaryColor)),
              const Center(
                child: Text(
                  'Other',
                ),
              ),
            ],
          ))
    ];
    return columns;
  }
}
