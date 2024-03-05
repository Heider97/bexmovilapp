import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../sale/details.dart';

class DataGridCheckBox extends StatefulWidget {
  const DataGridCheckBox({super.key});

  @override
  State<DataGridCheckBox> createState() => _DataGridCheckBoxState();
}

class _DataGridCheckBoxState extends State<DataGridCheckBox> {
  final DataGridController _dataGridController = DataGridController();

  late ClientDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employeeDataSource = ClientDataSource(clientData: getEmployeeData());
  }

  List<Client> getEmployeeData() {
    return [
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022'),
      Client(
          nitCliente: '001',
          docType: 'CC',
          movDate: '20/Agosto/2022',
          expireDate: '20/Agosto/2022')
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
            showCheckboxColumn: true,
            //  allowFiltering: true,
            selectionMode: SelectionMode.multiple,
            controller: _dataGridController,
            columns: getColumns(theme),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text('Gran total : \$458.592.500',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        )
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
          minimumWidth: Screens.width(context) * 0.34,
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
    ];
    return columns;
  }
}
