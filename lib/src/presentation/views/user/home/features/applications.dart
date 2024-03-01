import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//utils
import '../../../../../utils/constants/strings.dart';
//cubit
import '../../../../cubits/home/home_cubit.dart';
//widgets
import '../widgets/app_item.dart';

class HomeApplications extends StatelessWidget {
  const HomeApplications({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<HomeCubit>().navigationService;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppItem(
                iconName: 'Vender',
                imagePath: 'assets/svg/sell.svg',
                onTap: () {
                  navigationService.goTo(Routes.routerRoute);
                }),
            AppItem(
                iconName: 'Cartera',
                imagePath: 'assets/svg/wallet.svg',
                onTap: () {
                  navigationService.goTo(Routes.walletprocess);
                }),
            AppItem(
                iconName: 'Mercadeo',
                imagePath: 'assets/svg/mercadeo.svg',
                onTap: () {
                  // _navigationService.goTo(Routes.mercadeo);
                }),
            AppItem(
                iconName: 'PQRS',
                imagePath: 'assets/svg/pqrs.svg',
                onTap: () {
                  // _navigationService.goTo(Routes.pqrs);
                }),
          ],
        ),
      ),
    );
  }
}
