import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//domain
import '../../../../../domain/models/invoice.dart';
import '../../../../../utils/constants/screens.dart';
import '../../sale/features/data_grid_sources.dart';

class WalletTableSummaries extends StatefulWidget {
  final List<Invoice> invoices;

  const WalletTableSummaries({super.key, required this.invoices});

  @override
  State<WalletTableSummaries> createState() => _WalletTableSummariesState();
}

class _WalletTableSummariesState extends State<WalletTableSummaries> {
  final DataGridController _dataGridController = DataGridController();
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SfDataGrid(
      gridLinesVisibility: GridLinesVisibility.both,
      rowHeight: 60,
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
      columnSizer: _customColumnSizer,
      source: InvoiceDataSource(invoiceData: widget.invoices),
      showCheckboxColumn: true,
      allowSorting: true,
      // allowMultiColumnSorting: true,
      selectionMode: SelectionMode.single,
      controller: _dataGridController,
      columns: getColumns(theme),
    );
  }

  List<GridColumn> getColumns(ThemeData theme) {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
        columnName: 'nummov',
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Factura',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        // allowFiltering: true,
        columnName: 'state',
        label: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Estado',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      GridColumn(
        allowFiltering: true,
        columnName: 'fecmov',
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
        minimumWidth: Screens.width(context) * 0.4,
        allowFiltering: true,
        columnName: 'preciomov',
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Valor',
                  textAlign: TextAlign.right,
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

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    style = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeHeaderCellWidth(column, style);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}
