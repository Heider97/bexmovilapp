
import 'package:connectivity_plus/connectivity_plus.dart';

import './network_cubit.dart';
import './network_event.dart';

class NetworkHelper {

  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkCubit().add(NetworkNotify());
      } else {
        NetworkCubit().add(NetworkNotify(isConnected: true));
      }
    });
  }
}