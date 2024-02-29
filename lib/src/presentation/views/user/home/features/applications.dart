import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//utils
import '../../../../../utils/constants/strings.dart';
//domain
import '../../../../../domain/models/application.dart';
//cubit
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../widgets/app_item.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_shimmer_loading.dart';

class HomeApplications extends StatelessWidget {
  final List<Application>? applications;

  const HomeApplications({super.key, required this.applications});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<HomeCubit>().navigationService;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: applications?.length ?? 0,
            itemBuilder: (context, index) => AppShimmerLoading(
                isLoading: state is HomeSynchronizing,
                child: AppItem(
                    iconName: applications![index].title!,
                    imagePath: applications![index].svg!,
                    onTap: () {
                      navigationService.goTo(applications![index].route!);
                    })),
          );
        }),
      ),
    );
  }
}
