import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/models/arguments.dart';
import '../../../../../domain/models/client.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client_wallet.dart';

class WalletClients extends StatefulWidget {
  final List<Client>? clients;

  const WalletClients({super.key, this.clients});

  @override
  State<WalletClients> createState() => _WalletClientsState();
}

class _WalletClientsState extends State<WalletClients>
    with SingleTickerProviderStateMixin {
  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.client &&
          widget.clients != null &&
          widget.clients!.isNotEmpty == true) {
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height - 200,
            child: ListView.builder(
                itemCount: widget.clients!.length,
                itemBuilder: (context, index) {
                  return CardClientWallet(
                    onTap: () {
                      walletBloc.navigationService.goTo(
                          AppRoutes.summariesWallet,
                          arguments: WalletArgument(
                              type: state.age!,
                              client: widget.clients![index]));
                    },
                    client: state.clients![index],
                  );
                }),
          ),
        );
      } else {
        return Center(child: AppText('No hay clientes'));
      }
    });
  }
}
