import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../../../domain/models/product.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client.dart';

class SaleProducts extends StatefulWidget {
  final List<Product>? products;

  const SaleProducts({super.key, this.products});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.products &&
          widget.products != null &&
          widget.products!.isNotEmpty) {
        return const SizedBox();
      } else {
        return Center(child: AppText('No hay Productos'));
      }
    });
  }
}
