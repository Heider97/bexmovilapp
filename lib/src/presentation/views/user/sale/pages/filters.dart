import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//features
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client_sale.dart';

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../../../../widgets/atoms/app_icon_button.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class FiltersSalePage extends StatefulWidget {
  const FiltersSalePage({super.key});

  @override
  State<FiltersSalePage> createState() => _FiltersSalePageState();
}

class _FiltersSalePageState extends State<FiltersSalePage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Const.space15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(needPrimary: true),
                AppText('Filtros'),
                AppIconButton(child: const Icon(Icons.restart_alt))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
