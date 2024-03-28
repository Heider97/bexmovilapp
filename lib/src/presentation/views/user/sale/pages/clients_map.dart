import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_draggable_scrollable_sheet.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/widgets/check_image.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/atoms.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/show_map_direction_widget.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  Future<Uint8List> _createMarkerImage() async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Draw Circle
    final Paint circlePaint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(20, 20), 20, circlePaint);

    // Draw Number
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '1',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(15, 12));

    final ui.Picture picture = recorder.endRecording();
    final ui.Image img = await picture.toImage(40, 40);
    final ByteData? byteData =
        await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<MapsBloc, MapsBlocState>(
      builder: (context, state) {
        return BlocBuilder<SaleBloc, SaleState>(
          builder: (context, saleState) {
            return Stack(
              fit: StackFit.expand,
              children: [
                /*       Container(
                  height: 100,
                  width: Screens.width(context),
                  color: Colors.transparent,
                  child: CarouselSlider(
                    items: state.clientsFounded,
                    carouselController: state.carouselController,
                    options: CarouselOptions(
                      height: 100,
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int index, _) async {
                        mapsBloc.add(OnCarouselPageChanged(index: index));
                      },
                    ),
                  ),
                ), */
                GoogleMap(
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    onMapCreated: (controller) {
                      mapsBloc.add(OnMapInitializedEvent(
                          controller, saleState.clients ?? [], context));
                    },
                    compassEnabled: false,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    /* 
                          {Marker(
                      markerId: MarkerId("marker1"),
                      position: LatLng(6.25184, -75.56359),
                      icon: BitmapDescriptor.fromBytes(_createMarkerImage())
                    )}, */
                    markers: state.markers.values.toSet(),
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(6.25184, -75.56359), zoom: 12)),
                CustomDraggableScrollableSheet()

                /*      (state.selectedClient != null)
                    ? Positioned(
                        bottom: 10,
                        right: 10,
                        child: Column(
                          children: [
                            gapH12,
                            Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape
                                      .circle, // Forma circular para el botón
                                ),
                                child: IconButton(
                                  color: Colors.black, // Color del icono
                                  onPressed: () {
                                    mapsBloc.add(CenterToUserLocation());
                                  },
                                  icon: const Icon(Icons.gps_fixed),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const AppBackButton(
                              needPrimary: true,
                            ),
                            gapW12,
                            Expanded(
                              child: CustomSearchBar(
                                  onChanged: (value) {
                                    mapsBloc.add(
                                        SearchClient(valueToSearch: value));
                                  },
                                  colorBackground: Colors.white,
                                  prefixIcon: Icon(Icons.search),
                                  controller: textController,
                                  hintText: 'Buscar cliente'),
                            ),
                          ],
                        ),
                      ), */

                /*         ],
                  ),
                ),
                (state.selectedClient != null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon(Icons.gps_fixed),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height: Screens.height(context) * 0.34,
                                child: Padding(
                                  padding: const EdgeInsets.all(Const.space18),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Const.space12),
                                      color: theme.cardColor,
                                      image: const DecorationImage(
                                          scale: 1.2,
                                          image: AssetImage(Assets.bgSquare),
                                          fit: BoxFit.none,
                                          opacity: 0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText.displayMedium(
                                                  'Detalles Cliente',
                                                  fontSize: 18,
                                                  textAlign: TextAlign.start,
                                                  color: theme.primaryColor,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    mapsBloc
                                                        .add(UnSelectClient());
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            theme.primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )

                                                /* mapsBloc
                                          .add(OnCarouselPageChanged(index: index)) */
                                              ],
                                            ),
                                          ),
                                          Card(
                                            surfaceTintColor: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text.rich(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text: 'Nombre: ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                .selectedClient!
                                                                .name!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text: 'Empresa: ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                    .selectedClient!
                                                                    .businessName ??
                                                                'No disponible',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text: 'Dirección: ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                    .selectedClient!
                                                                    .address ??
                                                                'No disponible',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () => launchUrl(
                                                      Uri.parse(
                                                          'tel://${state.selectedClient!.cellphone}'),
                                                    ),
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Const.space12),
                                                      elevation: 2,
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(Const
                                                                        .space12),
                                                          ),
                                                          /*    height:
                                                            Screens.height(context) * 0.08, */
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.call,
                                                                  color: theme
                                                                      .primaryColor,
                                                                ),
                                                                gapW12,
                                                                AppText
                                                                    .bodyMedium(
                                                                  'Llamar',
                                                                  color: theme
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    return await MapsSheet.show(
                                                        context: context,
                                                        onMapTap: (map) {
                                                          map.showDirections(
                                                            destination: Coords(
                                                              double.parse(state
                                                                  .selectedClient!
                                                                  .latitude!),
                                                              double.parse(state
                                                                  .selectedClient!
                                                                  .longitude!),
                                                            ),
                                                            destinationTitle: state
                                                                .selectedClient!
                                                                .businessName,
                                                            originTitle:
                                                                'Origen',
                                                            waypoints: null,
                                                            directionsMode:
                                                                DirectionsMode
                                                                    .driving,
                                                          );
                                                        });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          Assets.waze,
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                        const Text(
                                                          'Waze',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ) */
                /*   : Container() */
              ],
            );
          },
        );
      },
    );
  }
}
