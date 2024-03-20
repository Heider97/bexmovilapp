import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../../../domain/models/application.dart';
//cubit
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../widgets/app_item.dart';
import '../../../../widgets/atomsbox.dart';

class HomeApplications extends StatelessWidget {
  final List<Application>? applications;

  const HomeApplications({super.key, required this.applications});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<HomeCubit>().navigationService;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...applications != null
                ? applications!.map((app) => AppShimmerLoading(
                    isLoading: state is HomeSynchronizing,
                    child: AppItem(
                        enabled: app.enabled ?? false,
                        iconName: app.title!,
                        imagePath: app.svg!,
                        onTap: () {
                          navigationService.goTo(app.route!);
                        })))
                : []
          ],
        );
      }),
    );
  }
}
