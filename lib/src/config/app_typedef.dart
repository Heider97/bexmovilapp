import 'package:flutter/material.dart';

typedef AudioCardBuilder = Widget Function(BuildContext context);
typedef CardBuilder = Card Function(BuildContext context);
typedef TextBuilder = Text Function(BuildContext context);
typedef ImageBuilder = Image Function(BuildContext context);
typedef ButtonBuilder = Widget Function(BuildContext context);
typedef IconButtonBuilder = Widget Function(BuildContext context);
typedef InputDecorationBuilder = InputDecoration Function(BuildContext context);
typedef ExpansionTileBuilder = ExpansionTileTheme Function(
    BuildContext context);
