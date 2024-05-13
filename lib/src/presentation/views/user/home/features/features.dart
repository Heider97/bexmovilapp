import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
//utils
import '../../../../../utils/constants/screens.dart';
//cubits
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class HomeFeatures extends StatelessWidget {
  const HomeFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (current, previous) => current.status != previous.status,
        builder: (context, state) {
          return SizedBox(
              height: 100,
              width: Screens.width(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.features != null ? state.features!.length : 0,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Skeletonizer(
                    enabled: state.status == HomeStatus.synchronizing ||
                        state.status == HomeStatus.loading,
                    child: AppCardFeature(
                        axis: Axis.horizontal,
                        text: state.features![index].descripcion ?? 'N/A',
                        url: state.features![index].urldesc ?? 'N/A',
                        color: index / 2 == 0 ? Colors.orange : Colors.green),
                  ),
                ),
              ));
        });
  }
}
