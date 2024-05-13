import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//cubits
import '../../../../cubits/home/home_cubit.dart';
//domain
import '../../../../../domain/models/feature.dart';
//widgets
import '../../../../widgets/atomsbox.dart';
import '../../../../../utils/constants/screens.dart';

class HomeFeatures extends StatelessWidget {
  const HomeFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (current, previous) =>
            current.runtimeType != previous.runtimeType,
        builder: (context, state) {


          return SizedBox(
              height: 100,
              width: Screens.width(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.features != null ? state.features!.length : 0,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AppShimmerLoading(
                    isLoading: state.status == HomeStatus.synchronizing ||
                        state.status == HomeStatus.loading,
                    child: AppCardFeature(
                        axis: Axis.horizontal,
                        text: state.features![index].descripcion!,
                        url: state.features![index].urldesc,
                        color: index / 2 == 0 ? Colors.orange : Colors.green),
                  ),
                ),
              ));
        });
  }
}
