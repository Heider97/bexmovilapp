import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//domain
import '../../../../../domain/models/invoice.dart';
import '../../../../../utils/constants/screens.dart';
import '../../sale/features/data_grid_sources.dart';


class WalletTableSummaries extends StatefulWidget {

  final List<Invoice> invoices;

  const WalletTableSummaries({super.key, required this.invoices });

  @override
  State<WalletTableSummaries> createState() => _WalletTableSummariesState();
}

class _WalletTableSummariesState extends State<WalletTableSummaries> {
  final DataGridController _dataGridController = DataGridController();

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
          print(
              'removedRows: ${element.getCells().first.value}}');
        }
      },
      onCellTap: (details) {},
      isScrollbarAlwaysShown: true,
      horizontalScrollController: ScrollController(),
      source: InvoiceDataSource(invoiceData: widget.invoices),

      // showCheckboxColumn: true,
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
                  'Factura',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      GridColumn(
        minimumWidth: Screens.width(context) * 0.1,

        // allowFiltering: true,
        sortIconPosition: ColumnHeaderIconPosition.end,
        columnName: 'total',
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
        minimumWidth: Screens.width(context) * 0.15,
        sortIconPosition: ColumnHeaderIconPosition.end,
        allowFiltering: true,
        columnName: 'walletAmmount',
        label: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Total',
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
