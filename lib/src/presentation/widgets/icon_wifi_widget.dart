import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/network/network_bloc.dart';

class IconConnection extends StatelessWidget {
  const IconConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkFailure) {
          return const Icon(Icons.wifi_off, color: Colors.black);
        } else if (state is NetworkSuccess) {
          return const Icon(Icons.wifi, color: Colors.black);
        } else {
          return const Icon(Icons.e_mobiledata, color: Colors.black);
        }
      },
    );
  }
}
