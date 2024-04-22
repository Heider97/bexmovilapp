import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'package:bexmovil/src/presentation/widgets/atoms/app_marker.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_user_marker.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getfinalCustomMarkerOrigin(
    {required String index, required BuildContext context}) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final startMarker = CustomMarker(context: context, index: index);
  startMarker.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMyLocationMarker(
    {required BuildContext context}) async {
  //OBTENER LA IMAGEN DEL MARCADOR
  final ByteData data = await rootBundle.load(Assets.imageProfile);
  final ui.Codec codec =
      await ui.instantiateImageCodec(data.buffer.asUint8List());
  final ui.Image markerImage = (await codec.getNextFrame()).image;

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final startMarker =
      CustomUserMarker(context: context, image: null, initials: 'Tú');
  startMarker.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
