import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  final LocalStorageService storageService;
  final NavigationService navigationService;

  IndexCubit(this.storageService, this.navigationService)
      : super(IndexState(
            index: 0,
            status: IndexStatus.initial,
            pageController: PageController(
              initialPage: 0,
              keepPage: true,
            )));

  void pageChanged(int index) {
    emit(state.copyWith(status: IndexStatus.success, index: index));
  }

  void bottomTapped(
    int index,
  ) {
    emit(state.copyWith(status: IndexStatus.success, index: index));
    state.pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
