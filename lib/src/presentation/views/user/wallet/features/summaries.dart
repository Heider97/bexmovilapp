import 'package:bexmovil/src/domain/models/invoice.dart';
import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/table_summaries_wallet.dart';

class WalletSummaries extends StatefulWidget {
  final List<Invoice>? invoices;

  const WalletSummaries({super.key, this.invoices});

  @override
  State<WalletSummaries> createState() => _WalletSummariesState();
}

class _WalletSummariesState extends State<WalletSummaries>
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
      if (state.status == WalletStatus.invoices &&
          widget.invoices != null &&
          widget.invoices!.isNotEmpty == true) {
        return SingleChildScrollView(
          child: SizedBox(
              height: size.height - 411,
              child: WalletTableSummaries(invoices: widget.invoices ?? [])),
        );
      } else {
        return Center(child: AppText('No hay facturas'));
      }
    });
  }
}
