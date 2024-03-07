import 'package:bexmovil/src/domain/models/invoice.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid_checkbox_source.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGridCheckBox extends StatefulWidget {
  const DataGridCheckBox({super.key});

  @override
  State<DataGridCheckBox> createState() => _DataGridCheckBoxState();
}

class _DataGridCheckBoxState extends State<DataGridCheckBox> {
  final DataGridController _dataGridController = DataGridController();

  InvoiceDataSource invoiceDataSource = InvoiceDataSource(invoiceData: [
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
    Invoice(
        code: 'asdasd',
        expirationDate: 'Asogihaoisg',
        numMov: 'apiosjfoias',
        value: 'Asogihaoisg'),
  ]);

  @override
  void initState() {
    super.initState();
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
            source: invoiceDataSource,
            showCheckboxColumn: true,
            allowSorting: true,
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
        columnName: 'name',
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        minimumWidth: Screens.width(context) * 0.25,
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
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'numMov',
        minimumWidth: Screens.width(context) * 0.35,
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Vencimiento',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'expirationDate',
        minimumWidth: Screens.width(context) * 0.1,
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Fecha de expiración',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'value',
        minimumWidth: Screens.width(context) * 0.5,
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Valor',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    return columns;
  }
}
