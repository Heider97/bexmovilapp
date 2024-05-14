import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../blocs/wallet/wallet_bloc.dart';

//domain
import '../../../../../domain/models/arguments.dart';

//atoms
import '../../../../widgets/organisms/app_section.dart';

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

class _WalletClientsViewState extends State<WalletClientsView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();

    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.add(LoadClients(range: widget.argument!.type));
  }

  @override
  void dispose() {
    walletBloc.add(LoadGraphics());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else if (state.status == WalletStatus.clients){
        return _buildBody(size, theme, state, context);
      } else {
        return const SizedBox();
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
