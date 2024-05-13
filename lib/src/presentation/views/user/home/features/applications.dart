import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

//cubit
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../widgets/app_item.dart';
import '../../../../widgets/atomsbox.dart';

class HomeApplications extends StatelessWidget {
  const HomeApplications({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<HomeCubit>().navigationService;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (current, previous) => current.status != previous.status,
          builder: (context, state) {
            print(state.applications);
            if (state.applications != null && state.applications!.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...state.applications!.map((app) => Skeletonizer(
                      enabled: state.status == HomeStatus.synchronizing ||
                          state.status == HomeStatus.loading,
                      ignoreContainers: true,
                      child: AppItem(
                          enabled: app.enabled ?? false,
                          iconName: app.title ?? 'N/A',
                          imagePath: app.svg,
                          onTap: () {
                            navigationService.goTo(app.route!);
                          })))
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
