import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_frame_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_menu_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletProcessView extends StatefulWidget {
  const WalletProcessView({super.key});

  @override
  State<WalletProcessView> createState() => _WalletProcessViewState();
}

class _WalletProcessViewState extends State<WalletProcessView> {
  List<DataRow> _dataRows = List.generate(
    10,
    (index) => DataRow(
      cells: [
        DataCell(Text('Factura $index')),
        DataCell(Text('Estado $index')),
        DataCell(Text('Vencimiento $index')),
        DataCell(Text('Valor $index')),
      ],
    ),
  );

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(primaryColorBackgroundMode: true),
                CustomMenuButton(
                  primaryColorBackgroundMode: true,
                )
              ],
            ),
          ),
          StepperWidget(
            currentStep: 1,
            steps: [
              StepData("Seleccionar Cliente", Assets.profileEnable,
                  theme.primaryColor, Assets.profileDisable),
              StepData("Seleccionar facturas", Assets.invoiceEnable,
                  theme.primaryColor, Assets.invoiceDisable),
              StepData("Realizar Acción", Assets.actionEnable,
                  theme.primaryColor, Assets.actionDisable)
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(Const.padding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(Const.space15)),
                      child: Padding(
                        padding: const EdgeInsets.all(Const.padding),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: theme.colorScheme.tertiary,
                            ),
                            gapW24,
                            Text(
                              'Número de factura',
                              style:
                                  TextStyle(color: theme.colorScheme.tertiary),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              const CustomFrameButtom(
                  icon: FontAwesomeIcons.locationArrow,
                  primaryColorBackgroundMode: true),
              gapW8,
              const CustomFrameButtom(
                  icon: Icons.tune, primaryColorBackgroundMode: true),
              gapW8,
            ],
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.6,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Scrollable(
                viewportBuilder: (BuildContext context, position) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      dataRowMinHeight: 1,                      
                      columns: [
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Factura'),
                            ],
                          ),

                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnIndex = columnIndex;
                              _sortAscending = ascending;
                              // Ordenar la lista de filas según la columna Factura
                              if (ascending) {
                                // Orden ascendente
                                _dataRows.sort((a, b) => a
                                    .cells[columnIndex].child
                                    .toString()
                                    .compareTo(
                                        b.cells[columnIndex].child.toString()));
                              } else {
                                // Orden descendente
                                _dataRows.sort((a, b) => b
                                    .cells[columnIndex].child
                                    .toString()
                                    .compareTo(
                                        a.cells[columnIndex].child.toString()));
                              }
                            });
                          },
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Estado'),
                            ],
                          ),
                          onSort: (columnIndex, ascending) {
                            // Lógica de ordenamiento para la columna Estado
                            print('Ordenar por Estado $ascending');
                          },
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Vencimiento'),
                              Icon(Icons.sort),
                            ],
                          ),
                          onSort: (columnIndex, ascending) {
                            // Lógica de ordenamiento para la columna Vencimiento
                            print('Ordenar por Vencimiento $ascending');
                          },
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Valor'),
                              Icon(Icons.sort),
                            ],
                          ),
                          onSort: (columnIndex, ascending) {
                            // Lógica de ordenamiento para la columna Valor
                            print('Ordenar por Valor $ascending');
                          },
                        ),
                      ],
                      rows: _dataRows,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(child: Text('asdasd'))
        ],
      ),
    );
  }
}
