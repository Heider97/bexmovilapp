abstract class ProcessingQueueEvent {}

class ProcessingQueueAdd extends ProcessingQueueEvent {}

class ProcessingQueueObserve extends ProcessingQueueEvent {}

class ProcessingQueueNotify extends ProcessingQueueEvent {
  final bool isConnected;

  ProcessingQueueNotify({this.isConnected = false});
}