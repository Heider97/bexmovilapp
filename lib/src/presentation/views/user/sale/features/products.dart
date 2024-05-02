import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../../../domain/models/product.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';

class SaleProducts extends StatelessWidget {
  final List<Product>? products;

  const SaleProducts({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.products &&
          products != null &&
          products!.isNotEmpty) {
        return SingleChildScrollView(
          child: SizedBox(
            height: Screens.height(context) * 0.50,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: products?.length,
                itemBuilder: (context, index) {
                  return AppText(products![index].nomProducto);
                }),
          ),
        );
      } else {
        return Center(child: AppText('No hay Productos'));
      }
    });
  }
}
