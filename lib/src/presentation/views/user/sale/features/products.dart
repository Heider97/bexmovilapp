import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_product_normal_sale.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_product_photo_sale.dart';
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


class SaleProducts extends StatefulWidget {
  final String codprecio;
  final String codbodega;

  const SaleProducts(
      {super.key, required this.codprecio, required this.codbodega});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts>
    with AutomaticKeepAliveClientMixin {
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

    print('fetching data products');
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await saleBloc.loadProductsPaginated(
          widget.codprecio, widget.codbodega, pageKey, _pageSize);

      List<Product> orderedProducts = List.from(newItems, growable: true);

      print("Orden actual: ${saleBloc.state.orderOption}");
      print("Productos antes de ordenar: $orderedProducts");

      switch (saleBloc.state.orderOption) {
        case OrderOption.codBarrasAsc:
          orderedProducts
              .sort((a, b) => (a.codBarra ?? '').compareTo(b.codBarra ?? ''));
          break;
        case OrderOption.codBarrasDesc:
          orderedProducts
              .sort((a, b) => (b.codBarra ?? '').compareTo(a.codBarra ?? ''));
          break;
        case OrderOption.nombreAsc:
          orderedProducts
              .sort((a, b) => a.nomProducto.compareTo(b.nomProducto));
          break;
        case OrderOption.nombreDesc:
          orderedProducts
              .sort((a, b) => b.nomProducto.compareTo(a.nomProducto));
          break;
        case OrderOption.codProductoAsc:
          orderedProducts.sort(
              (a, b) => (a.codProducto ?? '').compareTo(b.codProducto ?? ''));
          break;
        case OrderOption.codProductoDesc:
          orderedProducts.sort(
              (a, b) => (b.codProducto ?? '').compareTo(a.codProducto ?? ''));
          break;
        default:
          break;
      }

      final isLastPage = orderedProducts.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(orderedProducts);
      } else {
        final nextPageKey = pageKey + orderedProducts.length;
        _pagingController.appendPage(orderedProducts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SaleBloc, SaleState>(
        // buildWhen: (previous, current) => previous.status != current.status || current.cant != previous.cant,
        builder: (context, state) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
                    color: Colors.grey[100], child: getGridProducts(state))),
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
                            onPressed: () {
                              
                            }, child: AppText('Vaciar')),
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

  Widget getGridProducts(SaleState state) {
    if (state.grid == 'normal') {
      return PagedListView<int, Product>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: CardProductNormalSale(
              product: item,
            ),
          ),
        ),
      );
    } else if (state.grid == 'photo') {
      return PagedGridView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: CardProductPhotoSale(
                product: item,
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ));
    } else if (state.grid == 'brief') {
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  getProductsQuantity(state) async {
    // return await _databaseRepository.getTotalProductQuantity(
    //     state.router!.dayRouter!,
    //     state.priceSelected!.codprecio!,
    //     state.warehouseSelected!.codbodega!,
    //     state.client!.id.toString());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
