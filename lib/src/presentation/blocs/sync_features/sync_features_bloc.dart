import 'dart:convert';
import 'package:bexmovil/src/data/datasources/remote/interceptor_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../blocs/processing_queue/processing_queue_bloc.dart';

//repositories

import '../../../domain/models/processing_queue.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
//domain
import '../../../domain/models/isolate.dart';
import '../../../domain/models/feature.dart';

import '../../../domain/models/requests/dynamic_request.dart';
import '../../../domain/models/requests/sync_priorities_request.dart';
import '../../../domain/models/responses/dynamic_response.dart';
//abstracts
import '../../../domain/abstracts/format_abstract.dart';
//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/resources/data_state.dart';
//services
import '../../../services/navigation.dart';
import '../../../services/storage.dart';

part 'sync_features_event.dart';
part 'sync_features_state.dart';

class SyncFeaturesBloc extends Bloc<SyncFeaturesEvent, SyncFeaturesState>
    with FormatDate {
  final DatabaseRepository databaseRepository;
  final ApiRepository apiRepository;
  final ProcessingQueueBloc processingQueueBloc;
  final NavigationService navigationService;
  final LocalStorageService storageService;

  SyncFeaturesBloc(this.databaseRepository, this.apiRepository,
      this.processingQueueBloc, this.navigationService, this.storageService)
      : super(SyncFeaturesInitial()) {
    on<SyncFeatureGet>(_observe);
    on<SyncFeatureLeave>(_go);
  }

  void _observe(event, emit) async {
    var features = await databaseRepository.getAllFeatures();
    var configs = await databaseRepository.getConfigs('login');

    try {
      emit(SyncFeaturesLoading(features: features));

      var version = configs.firstWhere((element) => element.name == 'version');

      var response = await apiRepository.priorities(
          request: SyncPrioritiesRequest(
              date: now(), version: version.value ?? "0"));

      if (response is DataSuccess) {
        helperFunction.runMigrations(response.data!.priorities!);

        var prioritiesAsync = response.data!.priorities!
            .where((element) => element.runBackground == 1)
            .toList(growable: false);

        helperFunction.insertAsyncPriorities(prioritiesAsync);

        var prioritiesSync = response.data!.priorities!
            .where((element) => element.runBackground == 0)
            .toList(growable: false);

        final startTime = DateTime.now();

        emit(SyncFeaturesLoading(
            features: features, processes: prioritiesSync.length));

        var futureInserts =
            await helperFunction.insertSyncPriorities(prioritiesSync);

        await Future.wait(futureInserts).whenComplete(() {
          final endTime = DateTime.now();
          final elapsedTime = endTime.difference(startTime);
          print(
              'Time taken for sequential calls: ${elapsedTime.inMilliseconds} ms');

          emit(SyncFeaturesSuccess(features: features));
        });
      } else {
        emit(SyncFeaturesFailure(features: features, error: response.error));
      }
    } catch (e) {
      emit(SyncFeaturesFailure(features: features, error: e.toString()));
    }
  }

  void _go(event, emit) async {
    emit(const SyncFeaturesSuccess());
  }

  void goToHome() {
    navigationService.goTo(AppRoutes.home);
  }
}
