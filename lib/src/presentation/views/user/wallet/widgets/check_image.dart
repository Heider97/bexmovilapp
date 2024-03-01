import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';

class CheckImage extends StatefulWidget {
  final String imageFromAsset;
  final String text;
  final Function? onTap;
  const CheckImage(
      {super.key,
      required this.imageFromAsset,
      required this.text,
      this.onTap});

  @override
  State<CheckImage> createState() => _CheckImageState();
}

class _CheckImageState extends State<CheckImage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor),
              borderRadius: (isSelected)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
                  : const BorderRadius.all(Radius.circular(10))),
          width: Screens.width(context) * 0.3,
          child: Column(
            children: [
              gapH4,
              Image.asset(
                widget.imageFromAsset,
                height: 55,
                width: 55,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        (isSelected)
            ? Container(
                width: Screens.width(context) * 0.3,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Seleccionado",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ]),
    );
  }
}
