import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../utils/constants/strings.dart';

//atoms
import '../../../../widgets/atomsbox.dart';


class WalletClientsView extends StatefulWidget {
  const WalletClientsView({super.key});

  @override
  State<WalletClientsView> createState() => _WalletClientsViewState();
}

class _WalletClientsViewState extends State<WalletClientsView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.add(LoadGraphics());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Const.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppBackButton(needPrimary: true),
                  AppIconButton(
                      onPressed: null,
                      child: Icon(Icons.menu,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
