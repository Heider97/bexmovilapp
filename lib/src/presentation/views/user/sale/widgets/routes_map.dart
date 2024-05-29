import 'package:flutter/material.dart' hide Router;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//domain
import '../../../../../domain/models/router.dart';

//blocs
import '../../../../blocs/location/location_bloc.dart';
import '../../../../blocs/maps_bloc/maps_bloc_bloc.dart';
import '../../../../blocs/sale/sale_bloc.dart';

class RoutesMap extends StatefulWidget {
  final Router router;
  const RoutesMap({super.key, required this.router});

  @override
  State<RoutesMap> createState() => _RoutesMapState();
}

class _RoutesMapState extends State<RoutesMap> {
  late MapsBloc mapsBloc;
  late SaleBloc saleBloc;
  late LocationBloc locationBloc;

  @override
  void initState() {
    mapsBloc = BlocProvider.of<MapsBloc>(context);
    saleBloc = BlocProvider.of<SaleBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);

    saleBloc.add(LoadClients(widget.router));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<MapsBloc, MapsBlocState>(
      builder: (context, state) {
        return BlocBuilder<SaleBloc, SaleState>(
          builder: (context, saleState) {
            final size = MediaQuery.of(context).size;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  GoogleMap(
                      mapToolbarEnabled: true,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      onMapCreated: (controller) {
                        mapsBloc.add(OnMapInitializedEvent(
                            controller,
                            saleState.clients ?? [],
                            context,
                            widget.router.dayRouter!,
                            locationBloc));
                      },
                      zoomControlsEnabled: false,
                      markers: state.markers.values.toSet(),
                      polylines: state.polylines.values.toSet(),
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(6.25184, -75.56359), zoom: 12)),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                        onPressed: () {
                          mapsBloc.add(CenterToUserLocation());
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.gps_fixed,
                            color: theme.primaryColor,
                          ),
                        )),
                  ),
                  Positioned(
                    bottom: 60,
                    right: 10,
                    child: IconButton(
                        onPressed: () {
                          mapsBloc.add(MoveToClientLocation());
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            FontAwesomeIcons.route,
                            color: theme.primaryColor,
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
