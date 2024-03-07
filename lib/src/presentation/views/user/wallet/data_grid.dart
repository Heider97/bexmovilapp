import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../sale/details.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class WalletDataGrid extends StatefulWidget {
  const WalletDataGrid({super.key});

  @override
  State<WalletDataGrid> createState() => _DataGridState();
}

class _DataGridState extends State<WalletDataGrid> {
  final DataGridController _dataGridController = DataGridController();

  //late ClientDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
  }

  Future<ClientDataSource> getEmployeeData() async {
    List<Client> clients =
        await _databaseRepository.getClientsByAgeRange([31, 60]);
    return ClientDataSource(clientData: clients); //data);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FutureBuilder(
              future: getEmployeeData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return SfDataGrid(
                    gridLinesVisibility: GridLinesVisibility.both,
                    rowHeight: 60,
                    frozenColumnsCount: 1,
                    frozenRowsCount: 0,
                    onSelectionChanged: (addedRows, removedRows) {
                      print('added: ${addedRows[0].getCells().first.value}');
                    },
                    onCellTap: (details) {},
                    isScrollbarAlwaysShown: true,
                    horizontalScrollController: ScrollController(),
                    source: snapshot.data!,

                    // showCheckboxColumn: true,
                    allowSorting: true,
                    // allowMultiColumnSorting: true,
                    selectionMode: SelectionMode.single,
                    controller: _dataGridController,
                    columns: getColumns(theme),
                  );
                } else if (snapshot.hasError) {
                  return (Text('Error'));
                } else {
                  return Text('other');
                }
              }),
        ),
      ],
    );
  }

  List<GridColumn> getColumns(ThemeData theme) {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'name',
        minimumWidth: Screens.width(context) * 0.5,
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Nombre',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        minimumWidth: Screens.width(context) * 0.04,

        // allowFiltering: true,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'overdueInvoices',
        label: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Facturas vencidas',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      GridColumn(
        minimumWidth: Screens.width(context) * 0.26,
        sortIconPosition: ColumnHeaderIconPosition.end,
        allowFiltering: true,
        columnName: 'walletAmmount',
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Cartera',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      /*    GridColumn(
          // allowFiltering: true,
          minimumWidth: Screens.width(context) * 0.35,
          columnName: 'Valor',
          sortIconPosition: ColumnHeaderIconPosition.end,
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Número de movimiento',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          columnWidthMode: ColumnWidthMode.lastColumnFill), */
      /*    GridColumn(
          minimumWidth: Screens.width(context) * 0.35,
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnName: 'Other',
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Fecha de Movimiento',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
      GridColumn(
          minimumWidth: Screens.width(context) * 0.35,
          columnName: 'expireDate',
          sortIconPosition: ColumnHeaderIconPosition.end,
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Fecha de Vencimiento',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )) */
    ];
    return columns;
  }
}
