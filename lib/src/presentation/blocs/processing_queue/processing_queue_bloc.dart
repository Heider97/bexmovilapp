import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

//utils
import '../../../core/functions.dart';
import '../../../domain/models/isolate.dart';
import '../../../services/storage.dart';
import '../../../utils/resources/data_state.dart';

//domain
import '../../../domain/models/processing_queue.dart';
import '../../../domain/models/requests/dynamic_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../../../domain/abstracts/format_abstract.dart';

//cubit
import '../network/network_bloc.dart';

part 'processing_queue_event.dart';
part 'processing_queue_state.dart';

class ProcessingQueueBloc
    extends Bloc<ProcessingQueueEvent, ProcessingQueueState> with FormatDate {
  final DatabaseRepository databaseRepository;
  final ApiRepository apiRepository;
  final NetworkBloc? networkBloc;
  final LocalStorageService storageService;

  final helperFunctions = HelperFunctions();

  ProcessingQueueBloc(this.databaseRepository, this.apiRepository,
      this.storageService, this.networkBloc)
      : super(const ProcessingQueueState(
            status: ProcessingQueueStatus.initial,
            processingQueues: [],
            dropdownFilterValue: 'all',
            dropdownStateValue: 'all')) {
    on<ProcessingQueueAdd>(_add);
    on<ProcessingQueueOne>(_one);
    on<ProcessingQueueObserve>(_observe);
    on<ProcessingQueueSender>(_sender);
    on<ProcessingQueueCancel>(_cancel);
    on<ProcessingQueueAll>(_all);
    on<ProcessingQueueSearchFilter>(_searchFilter);
    on<ProcessingQueueSearchState>(_searchState);
  }

  final itemsFilter = [
    {'key': 'all', 'value': 'Todos'},
    {'key': 'processing', 'value': 'Procesando'},
    {'key': 'error', 'value': 'Error'},
    {'key': 'incomplete', 'value': 'Incompleto'},
    {'key': 'done', 'value': 'Enviado'},
  ];

  final itemsState = [
    {'key': 'all', 'value': 'Todos'},
    {'key': 'store_transaction_start', 'value': 'Transacción inicio'},
    {'key': 'store_transaction_arrived', 'value': 'Transacción de llegada'},
    {'key': 'store_transaction_summary', 'value': 'Transacción de factura'},
    {'key': 'store_transaction', 'value': 'Transacción'},
    {'key': 'store_transaction_product', 'value': 'Transacción de producto'},
    {'key': 'store_locations', 'value': 'Localizaciones'},
    {'key': 'store_work_status', 'value': 'Estado de la planilla'},
  ];

  static void heavyTask(IsolateModel model) {
    for (var i = 0; i < model.iteration; i++) {
      model.functions[i];
    }
  }

  Future<void> addProcessingQueue(ProcessingQueue processingQueue) async {
    await databaseRepository.insertProcessingQueue(processingQueue);
    add(ProcessingQueueObserve());
  }

  Stream get resolve {
    return Stream.periodic(const Duration(seconds: 30), (int value) async {
      await _getProcessingQueue();
      return true;
    });
  }

  Stream<List<ProcessingQueue>> get todos {
    return databaseRepository.watchAllProcessingQueues();
  }

  Future<int> countProcessingQueueIncompleteToTransactions() {
    return databaseRepository.countProcessingQueueIncompleteToTransactions();
  }

  Stream<List<Map<String, dynamic>>>
      getProcessingQueueIncompleteToTransactions() {
    return databaseRepository.getProcessingQueueIncompleteToTransactions();
  }

  Future<List<ProcessingQueue>> getData(int? page, int? limit) {
    return databaseRepository.getAllProcessingQueuesPaginated(page, limit);
  }

  Future<void> _getProcessingQueue() async {
    if (networkBloc != null && networkBloc?.state is NetworkSuccess) {
      var queues = await databaseRepository.getAllProcessingQueuesIncomplete();
      sendProcessingQueues(queues);
    }
  }

  void _one(ProcessingQueueOne event, emit) async {
    emit(state.copyWith(status: ProcessingQueueStatus.loading));
    var processingQueue =
        await databaseRepository.findProcessingQueue(event.id);
    emit(state.copyWith(
        status: ProcessingQueueStatus.success,
        processingQueue: processingQueue));
  }

  void _all(event, emit) async {
    var processingQueues =
        await databaseRepository.getAllProcessingQueues(null, null);
    emit(state.copyWith(
        status: ProcessingQueueStatus.success,
        processingQueues: processingQueues));
  }

  void _add(ProcessingQueueAdd event, emit) async {
    var id =
        await databaseRepository.insertProcessingQueue(event.processingQueue);
    event.processingQueue.id = id;
    if (networkBloc != null && networkBloc?.state is NetworkSuccess) {
      sendProcessingQueue(event.processingQueue);
    }

    emit(state.copyWith(status: ProcessingQueueStatus.success));
  }

  void _observe(event, emit) {
    if (networkBloc != null &&
        networkBloc?.state is NetworkSuccess &&
        state.status == ProcessingQueueStatus.success) {
      _getProcessingQueue();
    }
    emit(state.copyWith(status: ProcessingQueueStatus.success));
  }

  void _sender(event, emit) async {
    emit(state.copyWith(status: ProcessingQueueStatus.sending));
    await _getProcessingQueue().whenComplete(
        () => emit(state.copyWith(status: ProcessingQueueStatus.success)));
  }

  void _cancel(event, emit) {
    emit(state.copyWith(status: ProcessingQueueStatus.success));
  }

  void _searchFilter(ProcessingQueueSearchFilter event, emit) async {
    var processingQueues = <ProcessingQueue>[];
    if (event.value != 'all') {
      processingQueues = await databaseRepository.getAllProcessingQueues(
          state.dropdownFilterValue, state.dropdownFilterValue);
    } else {
      processingQueues =
          await databaseRepository.getAllProcessingQueues(null, null);
    }

    emit(state.copyWith(
        dropdownFilterValue: event.value,
        status: ProcessingQueueStatus.success,
        processingQueues: processingQueues));
  }

  void _searchState(ProcessingQueueSearchState event, emit) async {
    var processingQueues = <ProcessingQueue>[];
    if (event.value != 'all') {
      processingQueues = await databaseRepository.getAllProcessingQueues(
          state.dropdownFilterValue, state.dropdownFilterValue);
    } else {
      processingQueues =
          await databaseRepository.getAllProcessingQueues(null, null);
    }
    emit(state.copyWith(
        dropdownStateValue: event.value,
        status: ProcessingQueueStatus.success,
        processingQueues: processingQueues));
  }

  void sendProcessingQueue(ProcessingQueue queue) async {
    queue.updatedAt = now();
    switch (queue.code) {
      case 'store_dynamic_data':
        try {
          var body = jsonDecode(queue.body);
          var table = body['table_name'];
          var content = body['content'];
          queue.task = 'processing';
          await databaseRepository.updateProcessingQueue(queue);
          var response = await apiRepository.syncDynamic(
              request: DynamicRequest(table, content));
          if (response is DataSuccess) {
            queue.task = 'done';
            await databaseRepository.insertAll(table, response.data!.data!);
          } else {
            queue.task = 'error';
            queue.error = response.error;
          }
          await databaseRepository.updateProcessingQueue(queue);
        } catch (e) {
          queue.task = 'error';
          queue.error = e.toString();
          await databaseRepository.updateProcessingQueue(queue);
        }
        break;
      default:
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
            //dude
            var content = body['content'];
            queue.task = 'processing';
            await databaseRepository.updateProcessingQueue(queue);
            var response = await apiRepository.syncDynamic(
                request: DynamicRequest(table, content));
            if (response is DataSuccess) {
              queue.task = 'done';
              await databaseRepository.insertAll(table, response.data!.data!);
            } else {
              queue.task = 'error';
              queue.error = response.error;
            }
            await databaseRepository.updateProcessingQueue(queue);
          } catch (e) {
            queue.task = 'error';
            queue.error = e.toString();
            await databaseRepository.updateProcessingQueue(queue);
          }
          break;
        default:
      }
    });
  }
}
