import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//utils

import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/wallet/wallet_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//domain
import '../../../../../domain/models/arguments.dart';

//atoms

import '../../../../widgets/organisms/app_section.dart';
import '../../../../widgets/user/custom_search_bar.dart';
import '../widgets/card_client_wallet.dart';
import '../../../../widgets/atomsbox.dart';
import '../../../../widgets/user/stepper.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class WalletClientsView extends StatefulWidget {
  final WalletArgument? argument;
  const WalletClientsView({super.key, this.argument});

  @override
  State<WalletClientsView> createState() => _WalletClientsViewState();
}

late SaleStepperBloc saleStepperBloc;

class _WalletClientsViewState extends State<WalletClientsView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.add(LoadClients(range: widget.argument!.type));
    saleStepperBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(size, theme, state, context);
      }
    });
  }

  Widget _buildBody(
      Size size, ThemeData theme, WalletState state, BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        ...state.sections != null
            ? state.sections!.map((e) => AppSection(
                title: e.name!,
                widgetItems: e.widgets ?? [],
                tabController: null))
            : [],
      ],
    ));
  }
}
