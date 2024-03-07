import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//utils
import '../../../utils/constants/strings.dart';
import '../atoms/app_text.dart';
//widgets

enum AppGlobalDialogType { success, info, warning, error }

/// A versatile background widget with multiple styles.
///
/// The [AppGlobalDialog] widget displays a background with one of the following styles:
/// - success
/// - info
/// - warning
/// - error
///
/// Each style has its own constructor, and some properties can be customized.
/// The card can react to touch events when an [onTap] callback is provided.
///
/// Use the following constructors to create the respective card styles:
/// - [AppGlobalDialog.success]
/// - [AppGlobalDialog.info]
/// - [AppGlobalDialog.warning]
/// - [AppGlobalDialog.error]
///
/// ## Customization
///
/// The appearance of the card can be customized using the following properties:
/// - [color] for the background color
/// - [opacity] for the background opacity
/// - [child] for the card's content
///
/// See also:
///
/// * [Container], which is used to create the gradient background.
/// * [Theme], which provides the colors used in the gradient.

// ignore: must_be_immutable
class AppGlobalDialog extends StatelessWidget {
  /// Creates an [AppGlobalBackground] widget.
  ///
  /// The [child] parameter must not be null.
  /// The [colors] parameter is optional, and if not provided, will use the primary
  /// and secondary colors from the [Theme]'s color scheme.

  /// The [elevation] defaults to 4.0.
  AppGlobalDialog.success({
    super.key,
    required this.title,
    this.description,
    this.image,
    this.onTap,
  }) {
    builder = (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(title, fontSize: 26),
                  const SizedBox(
                    height: 20,
                  ),
                  if (image != null)
                    SvgPicture.asset(image!, height: 100, width: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(description!,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AppText('Activar', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      );
    };
  }

  AppGlobalDialog.info({
    super.key,
    required this.title,
    this.description,
    this.image,
    this.onTap,
  }) {
    builder = (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(title, fontSize: 26),
                  const SizedBox(
                    height: 20,
                  ),
                  if (image != null)
                    SvgPicture.asset(image!, height: 100, width: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(description!,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AppText('Activar', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      );
    };
  }

  AppGlobalDialog.warning({
    super.key,
    required this.title,
    this.description,
    this.image,
    this.onTap,
  }) {
    builder = (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(title, fontSize: 26),
                  const SizedBox(
                    height: 20,
                  ),
                  if (image != null)
                    SvgPicture.asset(image!, height: 100, width: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(description!,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AppText('Activar', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      );
    };
  }

  AppGlobalDialog.error({
    super.key,
    required this.title,
    this.description,
    this.image,
    this.onTap,
  }) {
    builder = (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(title, fontSize: 26),
                  const SizedBox(
                    height: 20,
                  ),
                  if (image != null)
                    SvgPicture.asset(image!, height: 100, width: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(description!,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AppText('Activar', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      );
    };
  }

  late WidgetBuilder builder;

  final String title;
  final String? description;
  final String? image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget background = builder.call(context);
    return background;
  }
}
