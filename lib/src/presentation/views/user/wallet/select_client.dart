import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid_checkbox.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/atomsbox.dart';

final NavigationService _navigationService = locator<NavigationService>();
final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class SelectClientWallet extends StatefulWidget {
  const SelectClientWallet({super.key});

  @override
  State<SelectClientWallet> createState() => _SelectClientWalletState();
}

class _SelectClientWalletState extends State<SelectClientWallet> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [

          const Expanded(child: WalletDataGrid()),

        ],
      ),
    );
  }
}
