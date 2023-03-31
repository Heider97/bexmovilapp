import 'package:flutter/material.dart';

//domain
import '../../../domain/models/product.dart';

const categoryHeight = 50.0;
const productHeight = 110.0;

class HomeBloc extends ChangeNotifier {
  List<TabCategory> tabs = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  List<Item> items = [];
  bool listen = true;

  void init(TickerProvider ticker) {
    tabController =
        TabController(length: rappiCategories.length, vsync: ticker);

    double offsetFrom = 0.0;
    double offsetTo = 0.0;

    for (var i = 0; i < rappiCategories.length; i++) {
      final category = rappiCategories[i];

      if (i > 0) {
        offsetFrom += rappiCategories[i - 1].products.length * productHeight;
      }

      if (i < rappiCategories.length - 1) {
        offsetTo =
            offsetFrom + rappiCategories[i + 1].products.length * productHeight;
      } else {
        offsetTo = double.infinity;
      }

      tabs.add(TabCategory(
          category: category,
          selected: (i == 0),
          offsetFrom: categoryHeight * i + offsetFrom,
          offsetTo: offsetTo));

      items.add(Item(
        category: category,
      ));

      for (var j = 0; j < category.products.length; j++) {
        items.add(Item(product: category.products[j]));
      }
    }

    scrollController.addListener(onScrollListener);
  }

  void onScrollListener() {
    if (listen) {
      for (var i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if (scrollController.offset >= tab.offsetFrom &&
            scrollController.offset <= tab.offsetTo &&
            !tab.selected) {
          onTapSelected(i, animationRequired: false);
          tabController.animateTo(i);
          break;
        }
      }
    }
  }

  void onTapSelected(int index, {bool animationRequired = true}) async {
    final selected = tabs[index];
    for (var i = 0; i < tabs.length; i++) {
      final condition = selected.category.name == tabs[i].category.name;
      tabs[i] = tabs[i].copyWith(condition);
    }

    notifyListeners();

    if (animationRequired) {
      listen = false;
      await scrollController.animateTo(selected.offsetFrom,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      listen = true;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(onScrollListener);
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }
}

class TabCategory {
  final Category category;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;

  TabCategory copyWith(bool selected) => TabCategory(
      category: category,
      selected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo);

  TabCategory(
      {required this.category,
      required this.selected,
      required this.offsetFrom,
      required this.offsetTo});
}

class Item {
  final Category? category;
  final Product? product;

  Item({this.category, this.product});

  bool get isCategory => category != null;
}
