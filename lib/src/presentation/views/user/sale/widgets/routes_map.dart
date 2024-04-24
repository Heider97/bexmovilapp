import 'package:bexmovil/src/presentation/blocs/location/location_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutesMap extends StatefulWidget {
  final String codeRouter;
  const RoutesMap({super.key, required this.codeRouter});

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
    locationBloc= BlocProvider.of<LocationBloc>(context);
    
    saleBloc.add(LoadClients(widget.codeRouter));
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
                    
                    
                      //mapType: MapType.satellite,
                      mapToolbarEnabled: true,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      //trafficEnabled: true,
                      onMapCreated: (controller) {
                        mapsBloc.add(OnMapInitializedEvent(
                            controller,
                            saleState.clients ?? [],
                            context,
                            widget.codeRouter,
                            locationBloc
                            ));
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
