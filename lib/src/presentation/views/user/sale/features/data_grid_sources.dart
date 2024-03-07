import 'package:bexmovil/src/domain/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InvoiceDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  InvoiceDataSource({required List<Invoice> invoiceData}) {
    _invoiceData = invoiceData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Factura', value: e.nummov),
      DataGridCell<String>(columnName: 'Estado', value: e.fecven),
      DataGridCell<String>(
          columnName: 'Vencimiento', value: e.fecven),
      DataGridCell<String>(columnName: 'Valor', value: e.preciomov),
    ]))
        .toList();
  }

  List<DataGridRow> _invoiceData = [];

  @override
  List<DataGridRow> get rows => _invoiceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            //alignment: Alignment.center,
            padding: const EdgeInsets.all(9.0),
            child: Text(
              e.value.toString(),
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
            ),
          );
        }).toList());
  }
}