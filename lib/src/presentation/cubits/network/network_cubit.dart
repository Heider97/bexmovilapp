import 'package:flutter_bloc/flutter_bloc.dart';

import './network_event.dart';
import './network_state.dart';
import './network_helper.dart';

class NetworkCubit extends Bloc<NetworkEvent, NetworkState> {
  NetworkCubit._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkCubit _instance = NetworkCubit._();

  factory NetworkCubit() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}