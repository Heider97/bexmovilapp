import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_product_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//domain
import '../../../../../domain/models/product.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/screens.dart';

//widgets
import '../../../../widgets/atoms/atoms.dart';
import '../widgets/custom_card_product.dart';

class SaleProducts extends StatefulWidget {
  final String codprecio;
  final String codbodega;

  const SaleProducts(
      {super.key, required this.codprecio, required this.codbodega});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  late SaleBloc saleBloc;
  int totalProducts = 0;

  static const _pageSize = 20;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await saleBloc.loadProductsPaginated(
          widget.codprecio, widget.codbodega, pageKey, _pageSize);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(
        // buildWhen: (previous, current) => previous.status != current.status || current.cant != previous.cant,
        builder: (context, state) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
              color: Colors.grey[100],
              child: PagedListView<int, Product>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: CardProductSale(
                      product: item,
                    ),
                  ),
                ),
              ),
            )),
            Material(
                elevation: 10,
                child: Container(
                  height: Screens.height(context) * 0.1,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Productos: ${state.totalProductsShippingCart ?? 0}',
                            ),
                            AppText(
                              'Total: ${''.formatted(state.totalPriceShippingCart ?? 0)}',
                            )
                          ],
                        ),
                      ),
                      Row(children: [
                        AppTextButton(
                            onPressed: null, child: AppText('Vaciar')),
                        gapW20,
                        AppTextButton(
                            child: AppText('Ver Carrito'),
                            onPressed: () {
                              saleBloc.navigationService
                                  .goTo(AppRoutes.cartSale);
                            })
                      ])
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }

  getProductsQuantity(state) async {
    // return await _databaseRepository.getTotalProductQuantity(
    //     state.router!.dayRouter!,
    //     state.priceSelected!.codprecio!,
    //     state.warehouseSelected!.codbodega!,
    //     state.client!.id.toString());
  }
}
