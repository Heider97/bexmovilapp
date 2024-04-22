import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_stepper.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/router_details_card.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/atoms.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDraggableScrollableSheet extends StatefulWidget {
  const CustomDraggableScrollableSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDraggableScrollableSheet> createState() =>
      _CustomDraggableScrollableSheetState();
}

/* ScrollController scrollController = ScrollController(); */
DraggableScrollableController scrollableController =
    DraggableScrollableController();

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DraggableScrollableSheet(
        controller: scrollableController,
        initialChildSize: 0.15,
        minChildSize: 0.15,
        maxChildSize: 0.95,
        snap: true,
        builder: (context, scrollController) {
          return Material(
            elevation: 1,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            color: Colors.grey[50],
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: theme.disabledColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        width: 100,
                        height: 4,
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText('Rutero',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                BlocBuilder<SaleBloc,
                                                    SaleState>(
                                                  builder: (context, state) {
                                                    return AppText(
                                                      state.selectedRouter!
                                                          .nameDayRouter!
                                                          .capitalizeString(),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                AppText('0 %',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                SizedBox(
                                                  width: 150,
                                                  height: 15,
                                                  child:
                                                      LinearProgressIndicator(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    backgroundColor: theme
                                                        .colorScheme.secondary,
                                                    value: 0.0,
                                                    color: theme.primaryColor,
                                                    semanticsLabel:
                                                        'Linear progress indicator',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    gapH8,
                                    BlocBuilder<SaleBloc, SaleState>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: _buildItem(
                                                  Icons.group,
                                                  theme.primaryColor,
                                                  ' ${state.selectedRouter!.quantityClient ?? 0}',
                                                  'clientes'),
                                            ),
                                            Expanded(
                                              child: _buildItem(
                                                  Icons.person,
                                                  Colors.blue,
                                                  ' 0',
                                                  'prospectos'),
                                            ),
                                            Expanded(
                                              child: _buildItem(
                                                  Icons.visibility_rounded,
                                                  Colors.deepPurple,
                                                  '  0',
                                                  'visitados'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ]))),
                      //  Container(height: 10,color: Colors.red,),
                      gapH12,
                      Divider(
                        thickness: 2,
                        color: theme.disabledColor,
                        endIndent: 10,
                        indent: 10,
                      ),
                      gapH12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AppText(
                              'Clientes',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomSearchBar(
                          onChanged: (value) {
                            //  mapsBloc.add(SearchClient(valueToSearch: value));
                          },
                          colorBackground: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          controller: TextEditingController(),
                          hintText: 'Buscar cliente',
                        ),
                      ),

                      BlocBuilder<SaleBloc, SaleState>(
                        builder: (context, state) {
                          if (state.status == SaleStatus.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.status == SaleStatus.success &&
                              state.clients!.isNotEmpty) {
                            return SizedBox(
                              height: Screens.height(context) * 0.8,
                              child: StepperExample(
                                clients: state.clients!,
                                //scrollController: scrollController,
                              ),
                            );
                          } else {
                            return Center(
                                child: AppText("No se encontraron clientes."));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Widget _buildItem(IconData icon, Color color, String count, String label) {
  return Row(
    children: [
      Opacity(
        opacity: 0.7,
        child: Icon(
          icon,
          color: color,
        ),
      ),
      Expanded(child: Text('$count  $label')),
    ],
  );
}
