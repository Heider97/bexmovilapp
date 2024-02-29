import 'package:bexmovil/src/presentation/widgets/user/expanded_section.dart';
import 'package:bexmovil/src/presentation/widgets/user/wallet/wallet_action.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class WalletActionList extends StatefulWidget {
  const WalletActionList({super.key});

  @override
  State<WalletActionList> createState() => _WalletActionListState();
}

bool expand = true;

class _WalletActionListState extends State<WalletActionList> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return WalletAction(index: index);
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: (expand)
                                ? Text('Ocultar resumen')
                                : Text('Ver resumen'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expand = !expand;
                            });
                          },
                          child: (expand)
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Transform.rotate(
                                      angle: pi / 2,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Transform.rotate(
                                      angle: -pi / 2,
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ExpandedSection(
                  expand: expand,
                  height: 150,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Some Info'),
                        Text('Some Info 2'),
                        Text('Some Info 3'),
                      ],
                    ),
                  )),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total \$5.464.565.465',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    /*  Text('\$5464565465',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)), */
                  ],
                ),
              ),
              SizedBox(
                width: Screens.width(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Liquidar',
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
