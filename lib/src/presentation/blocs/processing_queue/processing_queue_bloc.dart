import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../domain/models/processing_queue.dart';
import '../../../domain/repositories/database_repository.dart';

//cubit
import '../network/network_bloc.dart';

part 'processing_queue_event.dart';
part 'processing_queue_state.dart';

class ProcessingQueueBloc extends Bloc<ProcessingQueueEvent, ProcessingQueueState> {

  final DatabaseRepository _databaseRepository;

  NetworkBloc? networkBloc;
  StreamSubscription? networkSubscription;
  bool? isConnected;

  ProcessingQueueBloc(this._databaseRepository, this.networkBloc) : super(ProcessingQueueInitial()) {
    on<ProcessingQueueObserve>(_observe);
    on<ProcessingQueueNotify>(_notifyStatus);
    if (networkBloc == null) return;
    networkSubscription = networkBloc?.stream.listen((networkState) {
      isConnected = networkState.runtimeType is NetworkSuccess;
    });
  }

  Future<void> addProcessingQueue(ProcessingQueue processingQueue) async {
    await _databaseRepository.insertProcessingQueue(processingQueue);
    add(ProcessingQueueObserve());
  }

  void _observe(event, emit) {
    if(isConnected != null && isConnected == true){
      print('activate procesing_queue');
    }
  }

  void _notifyStatus(ProcessingQueueNotify event, emit) {
    event.isConnected ? emit(ProcessingQueueSuccess()) : emit(ProcessingQueueFailure());
  }
}