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
                IconButton(onPressed: () {}, icon: Icon(Icons.gps_fixed)),
                Stack(
                  children: [
                    Positioned(
                        right: 10,
                        top: 40,
                        child: Row(
                          children: [
                            Text(
                              'Mostrar prospectos',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors
                                      .black /* fontWeight: FontWeight.bold */),
                            ),
                            gapW12,
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.person),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        right: 10,
                        top: 90,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.gps_fixed),
                            color: Colors.black,
                          ),
                        )),
                    Positioned(
                        right: 10,
                        top: 140,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.gps_fixed),
                            color: Colors.black,
                          ),
                        )),
                    GoogleMap(
                        myLocationEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        onMapCreated: (controller) {
                          mapsBloc.add(OnMapInitializedEvent(
                              controller, saleState.clients ?? [], context));
                        },
                        compassEnabled: false,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        markers: state.markers.values.toSet(),
                        initialCameraPosition: const CameraPosition(
                            target: LatLng(6.25184, -75.56359), zoom: 12)),
                  ],
                ),
                const CustomDraggableScrollableSheet(),
              ],
            );
          },
        );
      },
    );
  }
}
