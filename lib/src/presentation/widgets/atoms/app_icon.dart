// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../utils/constants/strings.dart';
// import 'app_glass.dart';
// import 'app_gradient_background.dart';
// import '../../../config/app_color_scheme.dart';
// import '../../../config/app_constants.dart';
// import '../../../config/app_typedef.dart';
//
// /// A customizable icon with various styles.
// ///
// /// The [AppIcon] widget provides multiple constructors to create icon buttons
// /// with different appearances, such as primary, secondary, glass, and gradient styles.
// ///
// ///
// /// The [onPressed] callback will be called when the button is tapped.
// ///
// /// Use the different constructors to create the desired button style:
// /// * [AppIcon] for primary style.
// /// * [AppIcon.secondary] for secondary style.
// /// * [AppIcon.glass] for glass effect style.
// /// * [AppIcon.gradient] for gradient background style.
// ///
// /// See also:
// ///
// /// * [IconButton], which is the base widget used to create the different styles of [AppIconButton].
//
// // ignore: must_be_immutable
// class AppIcon extends StatelessWidget {
//   /// Creates an [AppIconButton] with the primary style.
//   ///
//   /// The [child] parameter must not be null.
//   AppIconButton({
//     super.key,
//     this.color,
//     required this.child,
//   }) {
//     builder = (context) {
//       return Material(
//         borderRadius: BorderRadius.circular(Const.radius) ,
//         elevation: 5,
//         child: Container(
//             decoration: BoxDecoration(
//
//                 borderRadius: BorderRadius.circular(Const.radius),
//                 color:color ?? Theme.of(context).colorScheme.primary),
//             child: IconButton(
//               onPressed: onPressed,
//               icon: child,
//             )),
//       );
//     };
//   }
//
//   /// Creates an [AppIconButton] with the secondary style.
//   ///
//   /// The [child] parameter must not be null.
//
//   AppIconButton.secondary({
//     super.key,
//     this.color,
//     required this.child,
//   }) {
//     builder = (context) {
//       return SvgPicture.asset(child);
//     };
//   }
//
//   /// A callback that returns an [IconButton] with the desired style.
//   late IconButtonBuilder builder;
//
//   /// The icon to display inside the button.
//   ///
//   /// This should typically be an [Icon] widget, but can be any [Widget] that
//   /// visually represents the button's intended action.
//   final Widget child;
//
//   final Color? color;
//
//   @override
//   Widget build(BuildContext context) {
//     Widget button = builder.call(context);
//     return button;
//   }
// }
//
// final appIconButtonThemeLight = IconButtonThemeData(
//   style: IconButton.styleFrom(
//     foregroundColor: AppColors.appColorSchemeLight.surface,
//     backgroundColor: AppColors.appColorSchemeLight.primary,
//     disabledForegroundColor:
//     AppColors.appColorSchemeLight.onSurface.withOpacity(0.38),
//     disabledBackgroundColor:
//     AppColors.appColorSchemeLight.onSurface.withOpacity(0.12),
//     shadowColor: AppColors.appColorSchemeLight.shadow,
//     surfaceTintColor: AppColors.appColorSchemeLight.surfaceTint,
//   ),
// );
//
// final appIconButtonThemeDark = IconButtonThemeData(
//   style: IconButton.styleFrom(
//     foregroundColor: AppColors.appColorSchemeDark.surface,
//     backgroundColor: AppColors.appColorSchemeDark.primary,
//     disabledForegroundColor:
//     AppColors.appColorSchemeDark.onSurface.withOpacity(0.38),
//     disabledBackgroundColor:
//     AppColors.appColorSchemeDark.onSurface.withOpacity(0.12),
//     shadowColor: AppColors.appColorSchemeDark.shadow,
//     surfaceTintColor: AppColors.appColorSchemeDark.surfaceTint,
//   ),
// );
