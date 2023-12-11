/* import 'package:bexmovil/src/domain/models/search_result.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BuildSearchItem extends StatelessWidget {
  final SearchResult searchResult;

  const BuildSearchItem({Key? key, required this.searchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (searchResult.type) {
      case "user":
        return _builUserCard(context);
      case "product":
        return _builUserCard(context);

      case "planner":
        return _builUserCard(context);

      default:
        return Container(
          child: Center(
            child: Text("Bir şeyler ters gitti!"),
          ),
        );
    }
  }


  Widget _builProductCard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/1611-online-offline.json',
              height: 180, width: 180),
          const Text('No tiene conexión o tu conexión es lenta.')
        ],
      ),
    );
  }

  Widget _builPlannerCard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/1611-online-offline.json',
              height: 180, width: 180),
          const Text('No tiene conexión o tu conexión es lenta.')
        ],
      ),
    );
  }
}
 */