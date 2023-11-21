<<<<<<< Updated upstream
=======
//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/utils/constants/colors.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//utils
import '../../../utils/constants/strings.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? child;
  final String? label;
  final String? labelLoading;
  final Color? color;
  final VoidCallback onTap;
  final bool isLoading;
  final double width;
  final double height;
  final double? labelSize;
  final EdgeInsetsGeometry? margin;

  const CustomElevatedButton({
    Key? key,
    this.label,
    this.labelLoading,
    this.color,
    this.child,
    required this.onTap,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 47,
    this.labelSize,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: (isLoading == true) ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Const.buttonRadius),
          ),
        ),
        child: (isLoading == true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitThreeBounce(
                    size: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(width: Const.space12),
                  Text(
                    labelLoading ?? '',
                    style: theme.textTheme.labelLarge,
                  )
                ],
              )
            : (label == '' || label == null)
                ? child
                : Text(
                    label ?? '',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: labelSize,
                    ),
                  ),
      ),
    );
  }
}
