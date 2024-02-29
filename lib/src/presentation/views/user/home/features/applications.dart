
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//utils
import '../../../../../utils/constants/strings.dart';
//cubit
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../widgets/app_item.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_shimmer_loading.dart';

class HomeApplications extends StatelessWidget {
  const HomeApplications({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<HomeCubit>().navigationService;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppShimmerLoading(
                  isLoading: state is HomeSynchronizing,
                  child: AppItem(
                      iconName: 'Vender',
                      imagePath: 'assets/svg/sell.svg',
                      onTap: () {
                        navigationService.goTo(Routes.saleRoute);
                      })),
              AppShimmerLoading(
                isLoading: state is HomeSynchronizing,
                child: AppItem(
                    iconName: 'Cartera',
                    imagePath: 'assets/svg/wallet.svg',
                    onTap: () {
                      navigationService.goTo(Routes.walletprocess);
                    }),
              ),
              AppShimmerLoading(
                isLoading: state is HomeSynchronizing,
                child: AppItem(
                    iconName: 'Mercadeo',
                    imagePath: 'assets/svg/mercadeo.svg',
                    onTap: () {
                      // _navigationService.goTo(Routes.mercadeo);
                    }),
              ),
              AppShimmerLoading(
                isLoading: state is HomeLoading,
                child: AppItem(
                    iconName: 'PQRS',
                    imagePath: 'assets/svg/pqrs.svg',
                    onTap: () {
                      // _navigationService.goTo(Routes.pqrs);
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
