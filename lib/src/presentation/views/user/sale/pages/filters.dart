import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atomsbox.dart';

//features
import '../features/filters.dart';

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
    Size size = MediaQuery.of(context).size;
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
            gapH8,
            BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
              if (state.filters != null && state.filters!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.filters!.length,
                    itemBuilder: (context, index) {
                      final filter = state.filters![index];
                      return FilterFeatureSalePage(filter: filter);
                    },
                  ),
                );
              } else {
                return Center(
                    child:
                        AppText('Filtros no configurados para este venedeor'));
              }
            }),
            AppElevatedButton(
                minimumSize: Size(size.width, 50),
                child: AppText('Ver resultados'))
          ],
        ),
      ),
    );
  }
}
