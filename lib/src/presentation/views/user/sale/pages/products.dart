import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';

import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';

import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/organisms/app_section.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductsView extends StatefulWidget {
  final ProductArgument arguments;

  const ProductsView({super.key, required this.arguments});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late SaleBloc saleBloc;
  bool gridMode = false;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(
        LoadProducts(widget.arguments.codbodega, widget.arguments.codprecio));
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(LoadWarehouses(
        codcliente: widget.arguments.codcliente,
        codprecio: widget.arguments.codprecio,
        codbodega: widget.arguments.codbodega));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(state, theme, context);
      }
    });
  }

  Widget _buildBody(state, ThemeData theme, context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomSearchBar(
                      onChanged: (value) {},
                      colorBackground: theme.colorScheme.secondary,
                      prefixIcon: const Icon(Icons.search),
                      controller: TextEditingController(),
                      hintText: 'Buscar producto',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppIconButton(
                    child: Icon(Icons.filter_alt_rounded,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AppIconButton(
                  child: Icon(
                      (gridMode)
                          ? Icons.grid_view_rounded
                          : Icons.grid_view_outlined,
                      color: theme.colorScheme.onPrimary),
                  onPressed: () {
                    setState(() {
                      gridMode = !gridMode;
                    });
                    //TODO: disable grid view. change icon too
                  },
                ),
              )
            ],
          ),
          ...state.sections != null
              ? state.sections!.map((e) => AppSection(
                  title: e.name!,
                  widgetItems: e.widgets ?? [],
                  tabController: null))
              : [],
          Material(
              elevation: 10,
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '0 productos',
                          style: theme.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(children: [
                      Text(
                        'Vaciar',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.primaryColor),
                      ),
                      gapW20,
                      InkWell(
                        onTap: () {
                          _navigationService.goTo(AppRoutes.shoppingCart);
                        },
                        child: SizedBox(
                          height: 40,
                          child: Material(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Text(
                                  'Ver Carrito',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ])
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
