import 'dart:ui' as ui;

import 'package:bexmovil/src/presentation/widgets/atoms/app_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getfinalCustomMarkerOrigin(
    {required String dailyPrice,
    required String model,
    required BuildContext context}) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final startMarker =
      CustomMarker(dailyPrice: dailyPrice, model: model, context: context);
  startMarker.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
