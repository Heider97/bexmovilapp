import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_draggable_scrollable_sheet.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/routes_map.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapClients extends StatefulWidget {
  final String codeRouter;
  const MapClients({super.key, required this.codeRouter});

  @override
  State<MapClients> createState() => _MapClientsState();
}

class _MapClientsState extends State<MapClients> {
  late MapsBloc mapsBloc;
  late SaleBloc saleBloc;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    mapsBloc = BlocProvider.of<MapsBloc>(context);
    saleBloc = BlocProvider.of<SaleBloc>(context);

    saleBloc.add(LoadClients(widget.codeRouter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(children: [
      BlocBuilder<MapsBloc, MapsBlocState>(
        builder: (context, state) {
          return SizedBox(
              width: Screens.width(context),
              height: Screens.height(context) * 0.85,
              child: Stack(
                children: [
                  RoutesMap(
                    codeRouter: widget.codeRouter,
                  ),
                  (state.gettingMarkers == true ||
                          state.gettingPolylines == true)
                      ? Dialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                gapH20,
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                                gapH20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Obteniendo marcadores '),
                                    (state.gettingPolylines == true)
                                        ? const Text('y trazando rutas')
                                        : const SizedBox()
                                  ],
                                ),
                                gapH20
                              ]))
                      : SizedBox()
                ],
              )

              /* Center(
                child: SizedBox(          
                  child: Text('Obteniendo...')),
              ) */
              );
        },
      ),
      const CustomDraggableScrollableSheet(),
    ]);
  }
}
