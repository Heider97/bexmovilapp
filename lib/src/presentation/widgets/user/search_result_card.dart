import 'package:bexmovil/src/domain/models/search_result.dart';
import 'package:bexmovil/src/presentation/providers/theme_provider.dart';
import 'package:bexmovil/src/presentation/views/user/home/widgets/app_item.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SearchResultCard extends StatefulWidget {
  final SearchResult? searchResult;
  const SearchResultCard({super.key, this.searchResult});

  @override
  State<SearchResultCard> createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  bool showActions = false;
  String label = '';
  Color? labelcolor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    fillCard();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        color: theme.cardColor,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Const.padding),
                    child: Row(
                      children: [
                        (widget.searchResult!.image != null &&
                                widget.searchResult!.image!.toLowerCase() !=
                                    'n')
                            ? ImagesWithShadow(
                                image: widget.searchResult!.image!,
                                gap: 1,
                                fromNetwork: true,
                              )
                            : Container(),
                        (widget.searchResult!.image != null &&
                                widget.searchResult!.image!.toLowerCase() !=
                                    'n')
                            ? gapW16
                            : Container(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Nombre ${widget.searchResult?.type} : ',
                                      style: theme.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: widget.searchResult?.name ??
                                            'No especifica',
                                        style: theme.textTheme.labelMedium)
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Código : ',
                                      style: theme.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: (widget.searchResult?.code ==
                                                    null ||
                                                widget.searchResult!.code
                                                        .toString() ==
                                                    '')
                                            ? 'No especifica'
                                            : widget.searchResult!.code
                                                .toString(),
                                        style: theme.textTheme.labelMedium)
                                  ],
                                ),
                              ),
                              (widget.searchResult?.unitOfSale != null)
                                  ? Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Unidad de venta : ',
                                            style: theme.textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          TextSpan(
                                              text: widget
                                                      .searchResult?.unitOfSale
                                                      .toString() ??
                                                  'No especifica',
                                              style:
                                                  theme.textTheme.labelMedium)
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<ThemeProvider>(
                    builder: (context, themeProvider, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: labelcolor ?? const Color(0XFFFCEFE7),
                          borderRadius: BorderRadius.circular(Const.space8)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 4, bottom: 4),
                        child: Center(
                          child: Text(label),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
            (showActions)
                ? Row(
                    children: [
                      Expanded(
                        child: Card(
                            color: theme.scaffoldBackgroundColor,
                            margin: const EdgeInsets.all(10.0),
                            child: Center(
                              child: AppItem(
                                  enabled: true,
                                  iconName: 'Vender',
                                  imagePath: 'assets/svg/sell.svg',
                                  onTap: () {
                                    //TODO FUNCION PARA AVERIGUAR EN QUE PARTE DEL PROCESO SE ENCUENTRA Y SI TIENE UNA TRANSACCION PENDIENTE..
                                    _navigationService.goTo(AppRoutes.routersSale);
                                  }),
                            )),
                      ),
                      Expanded(
                        child: Card(
                            color: theme.scaffoldBackgroundColor,
                            margin: const EdgeInsets.all(10.0),
                            child: Center(
                              child: AppItem(
                                  enabled: true,
                                  iconName: 'Mercadeo',
                                  imagePath: 'assets/svg/mercadeo.svg',
                                  onTap: () {
                                    //TODO::[Heider Zapa] GO TO MERCADEO
                                  }),
                            )),
                      ),
                      Expanded(
                        child: Card(
                            color: theme.scaffoldBackgroundColor,
                            margin: const EdgeInsets.all(10.0),
                            child: Center(
                              child: AppItem(
                                  enabled: true,
                                  iconName: 'Cartera',
                                  imagePath: 'assets/svg/wallet.svg',
                                  onTap: () {
                                    _navigationService.goTo(AppRoutes.dashboardWallet);
                                  }),
                            )),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  fillCard() {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    if (widget.searchResult!.type != null) {
      switch (widget.searchResult!.type!.toLowerCase()) {
        case 'cliente':
          showActions = true;
          label = 'cliente';
          labelcolor = themeProvider.isDarkTheme
              ? const Color(0XFF25C87C)
              : Colors.green.shade50;
          break;

        case 'producto':
          showActions = false;
          label = 'producto';
          labelcolor = themeProvider.isDarkTheme
              ? const Color(0XFFFEAD1D)
              : const Color(0xFFE3F0FF);
          break;

        case 'rutero':
          break;

        default:
          showActions = false;
          label = 'N/A';

          break;
      }
    }
  }
}
