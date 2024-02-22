import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/nums.dart';
import '../../../utils/constants/strings.dart';

//domain
import '../../../domain/models/user.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/repositories/database_repository.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'home_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();

class HomeCubit extends Cubit<HomeState> {
  final DatabaseRepository _databaseRepository;

  HomeCubit(this._databaseRepository) : super(const HomeLoading());

  Future<void> init() async {
    final user = User.fromMap(_storageService.getObject('user')!);
    var features = await _databaseRepository.getAllFeatures();
    var kpis = await _databaseRepository.getAllKpis();
    print('estoy aquiiiii');
    print(kpis.length);

    emit(HomeSuccess(user: user, features: features, kpis: kpis));
  }

  void dispose() {
    emit(const HomeLoading());
    // scrollController.removeListener(onScrollListener);
    // scrollController.dispose();
    // tabController.dispose();
  }

  Future<void> logout() async {
    await Future.wait([
      //DELETE  DATABASE INFORMATION
    ]);

    _storageService.remove('token');
    _navigationService.replaceTo(Routes.loginRoute);
  }
}
