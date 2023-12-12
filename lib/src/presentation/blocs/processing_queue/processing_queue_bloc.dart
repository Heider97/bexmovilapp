import 'dart:async';
import 'dart:convert';
import 'package:bexmovil/src/core/abstracts/FormatAbstract.dart';
import 'package:bexmovil/src/domain/models/requests/dynamic_request.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../domain/models/processing_queue.dart';
import '../../../domain/repositories/database_repository.dart';

//cubit
import '../../../utils/resources/data_state.dart';
import '../network/network_bloc.dart';

part 'processing_queue_event.dart';
part 'processing_queue_state.dart';

class ProcessingQueueBloc extends Bloc<ProcessingQueueEvent, ProcessingQueueState> with FormatDate {

  final DatabaseRepository _databaseRepository;
  final ApiRepository _apiRepository;

  NetworkBloc? networkBloc;
  StreamSubscription? networkSubscription;
  bool? isConnected;

  ProcessingQueueBloc(this._databaseRepository,  this._apiRepository, this.networkBloc) : super(ProcessingQueueInitial()) {
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

  void _observe(event, emit) async {
    if(isConnected != null && isConnected == true){
      print('activate procesing_queue');
      var queues = await _databaseRepository.getAllProcessingQueues();
      sendProcessingQueues(queues);
    }
  }

  Future<void> sendProcessingQueues(List<ProcessingQueue> queues) async {
    await Future.forEach(queues, (queue) async {
      queue.updatedAt = now();
      switch (queue.code) {
        case 'store_dynamic_data':
          try {
            var body = jsonDecode(queue.body);
            var table = body['table_name'];
            queue.task = 'processing';
            await _databaseRepository.updateProcessingQueue(queue);
            var response =
            await _apiRepository.syncDynamic(request: DynamicRequest(table));
            if (response is DataSuccess) {
              queue.task = 'done';
              await _databaseRepository.insertAll(table, response.data!.data!);
            } else {
              queue.task = 'error';
              queue.error = response.error;
            }
            await _databaseRepository.updateProcessingQueue(queue);
          } catch (e) {
            queue.task = 'error';
            queue.error = e.toString();
            await _databaseRepository.updateProcessingQueue(queue);
          }
          break;
        default:
      }
    });
  }



  void _notifyStatus(ProcessingQueueNotify event, emit) {
    event.isConnected ? emit(ProcessingQueueSuccess()) : emit(ProcessingQueueFailure());
  }
}