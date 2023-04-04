import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/nums.dart';

//domain
import '../../../domain/models/category.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/database_repository.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';

part 'home_state.dart';
part 'tab_category.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class HomeCubit extends Cubit<HomeState> {
  final DatabaseRepository _databaseRepository;

  HomeCubit(this._databaseRepository) : super(const HomeLoading());

  List<TabCategory> tabs = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool listen = true;

  Future<void> init(TickerProvider ticker) async {
    final categories = await _databaseRepository.getAllCategoriesWithProducts();

    final companyName = _storageService.getString('company_name');

    tabController = TabController(length: categories.length, vsync: ticker);

    double offsetFrom = 0.0;
    double offsetTo = 0.0;

    for (var i = 0; i < categories.length; i++) {
      final category = categories[i];

      if (i > 0) {
        offsetFrom += categories[i - 1].products!.length * productHeight;
      }

      if (i < categories.length - 1) {
        offsetTo =
            offsetFrom + categories[i + 1].products!.length * productHeight;
      } else {
        offsetTo = double.infinity;
      }

      tabs.add(TabCategory(
          category: category,
          selected: (i == 0),
          offsetFrom: categoryHeight * i + offsetFrom,
          offsetTo: offsetTo));
    }

    scrollController.addListener(onScrollListener);

    emit(HomeSuccess(categories: categories, companyName: companyName));
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

    if (animationRequired) {
      listen = false;
      await scrollController.animateTo(selected.offsetFrom,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      listen = true;
    }
  }

  void dispose() {
    scrollController.removeListener(onScrollListener);
    scrollController.dispose();
    tabController.dispose();
  }
}
