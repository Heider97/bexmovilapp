import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../domain/models/processing_queue.dart';
import '../../../domain/repositories/database_repository.dart';

//cubit
import '../../cubits/network/network_cubit.dart';
import '../../cubits/network/network_state.dart';

import './processing_queue_event.dart';
import './processing_queue_state.dart';

class ProcessingQueueCubit extends Bloc<ProcessingQueueEvent, ProcessingQueueState> {

  final DatabaseRepository _databaseRepository;

  NetworkCubit? networkCubit;
  StreamSubscription? networkSubscription;
  bool? isConnected;

  ProcessingQueueCubit(this._databaseRepository, this.networkCubit) : super(ProcessingQueueInitial()) {
    on<ProcessingQueueObserve>(_observe);
    on<ProcessingQueueNotify>(_notifyStatus);
    if (networkCubit == null) return;
    networkSubscription = networkCubit?.stream.listen((networkState) {
      isConnected = networkState.runtimeType is NetworkSuccess;
    });
  }

  Future<void> addProcessingQueue(ProcessingQueue processingQueue) async {
    await _databaseRepository.insertProcessingQueue(processingQueue);
    add(ProcessingQueueObserve());
  }

  void _observe(event, emit) {
    print('***');
    print(isConnected);
    if(isConnected != null && isConnected == true){
      print('activate procesing_queue');
    }
  }

  void _notifyStatus(ProcessingQueueNotify event, emit) {
    event.isConnected ? emit(ProcessingQueueSuccess()) : emit(ProcessingQueueFailure());
  }
}