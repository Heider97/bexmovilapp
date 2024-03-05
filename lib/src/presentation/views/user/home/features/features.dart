import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//cubits
import '../../../../cubits/home/home_cubit.dart';
//domain
import '../../../../../domain/models/feature.dart';
//widgets
import '../../../../widgets/global/app_card_feature.dart';
import '../../../../widgets/atoms/app_shimmer_loading.dart';

class HomeFeatures extends StatelessWidget {
  final List<Feature>? features;

  const HomeFeatures({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (current, previous) =>
            current.runtimeType != previous.runtimeType,
        builder: (context, state) {
          return SizedBox(
              height: 120,
              width: 500,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: features != null ? features!.length : 0,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AppShimmerLoading(
                    isLoading:
                        state is HomeSynchronizing || state is HomeLoading,
                    child: AppCardFeature(
                        axis: Axis.horizontal,
                        text: features![index].descripcion!,
                        url: features![index].urldesc,
                        color: index / 2 == 0 ? Colors.orange : Colors.green),
                  ),
                ),
              ));
        });
  }
}
