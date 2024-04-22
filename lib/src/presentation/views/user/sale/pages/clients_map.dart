import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_draggable_scrollable_sheet.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/routes_map.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/widgets/check_image.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/atoms.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/show_map_direction_widget.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MapAvailableCars extends StatefulWidget {
  final String codeRouter;
  const MapAvailableCars({super.key, required this.codeRouter});

  @override
  State<MapAvailableCars> createState() => _MapAvailableCarsState();
}

class _MapAvailableCarsState extends State<MapAvailableCars> {
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
      SizedBox(
        width: Screens.width(context),
        height: Screens.height(context) * 0.85,
        child: RoutesMap(
          codeRouter: widget.codeRouter,
        ),
      ),
      const CustomDraggableScrollableSheet(),
    ]);
  }
}
