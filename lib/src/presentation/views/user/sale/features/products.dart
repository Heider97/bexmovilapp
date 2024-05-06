import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../../../domain/models/product.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/user/product_card.dart';
import '../widgets/product_card_row.dart';

class SaleProducts extends StatefulWidget {
  final List<Product>? products;

  const SaleProducts({super.key, this.products});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(ResetStatus(status: SaleStatus.clients));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.products &&
          widget.products != null &&
          widget.products!.isNotEmpty) {
        return SizedBox(
          height: Screens.height(context) * 0.62,
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.products?.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: widget.products![index],
                  refresh: () {},
                );
              }),
        );
      } else {
        return Center(child: AppText('No hay Productos'));
      }
    });
  }
}
