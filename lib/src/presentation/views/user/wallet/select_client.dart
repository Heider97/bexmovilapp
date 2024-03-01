//TODO: [Heider Zapa] organize
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';

class SelectClientWallet extends StatefulWidget {
  const SelectClientWallet({super.key});

  @override
  State<SelectClientWallet> createState() => _SelectClientWalletState();
}

class _SelectClientWalletState extends State<SelectClientWallet> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSearchBar(
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.primaryColor,
                      ),
                      controller: textController,
                      hintText: 'Nombre o código del producto'),
                ),
              ),
              // const CustomFrameButtom(
              //     icon: FontAwesomeIcons.locationArrow,
              //     primaryColorBackgroundMode: true),
              // gapW8,
              // const CustomFrameButtom(
              //     icon: Icons.tune, primaryColorBackgroundMode: true),
              gapW8,
            ],
          ),
          const Expanded(child: WalletDataGrid()),
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
                  'Siguiente',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
