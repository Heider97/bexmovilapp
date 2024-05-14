import 'package:flutter/material.dart';
import '../../../utils/constants/strings.dart';

/// A customizable back button for the atomsbox library
///
/// The [AppBackButton] widget is a customizable button that, when pressed,
/// navigates to the previous screen. By default, it uses the [Navigator.maybePop]
/// method to determine the appropriate action. However, if an [onPressed]
/// callback is provided, it will be executed instead.
///
/// The button displays a [BackButtonIcon] with colors and tooltip text based
/// on the current theme and [MaterialLocalizations].
///
/// See also:
///
/// * [IconButton], which is the underlying button used for the [AppBackButton].
/// * [BackButtonIcon], which provides the default icon for the [AppBackButton].
/// * [Navigator], which provides navigation functionality for the app.
class AppBackButton extends StatelessWidget {
  /// Creates an app back button.
  ///
  /// The [onPressed] callback is optional. If omitted, the button will use the
  /// [Navigator.maybePop] method to determine the appropriate action.
  const AppBackButton({super.key, this.onPressed, this.needPrimary});

  /// A callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this callback is provided, it will be called instead of the default
  /// behavior of navigating to the previous screen.
  ///
  /// If this callback is null, the button will use the [Navigator.maybePop]
  /// method to determine the appropriate action.
  final VoidCallback? onPressed;
  final bool? needPrimary;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
