import 'package:bexmovil/src/presentation/views/user/sale/index.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

//cubit
import '../../presentation/cubits/home/home_cubit.dart';

//utils
import '../../utils/constants/strings.dart';

//domain
import '../../domain/models/user.dart';

//services
import '../../locator.dart';
import '../../services/navigation.dart';
import '../../services/storage.dart';

final NavigationService _navigationService = locator<NavigationService>();
final LocalStorageService _storageService = locator<LocalStorageService>();

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key, this.user, this.companyName}) : super(key: key);

  final String? companyName;
  final User? user;

  late HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          gapH28,
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () => homeCubit.logout(),
                    child: CircleAvatar(
                      radius: 25,
                      child: user != null && user!.name != null
                          ? Text(user!.name![0])
                          : const Text('U'),
                    )),
              ],
            ),
          ),
          gapH68,
          _createDrawerItem(
              context: context,
              icon: Icons.notification_add,
              text: 'Notificaciones',
              onTap: () => _navigationService.goTo(Routes.calendarRoute),
              image: 'assets/svg/bell.svg',
              countNotifications: 222),
          gapH12,
          _createDrawerItem(
              context: context,
              icon: Icons.sell,
              text: 'Vender',
              onTap: () => _navigationService.goTo(Routes.saleRoute),
              image: 'assets/svg/sell.svg',
              countNotifications: 0),
          gapH12,
          _createDrawerItem(
              context: context,
              icon: Icons.business_center,
              text: 'Cartera',
              onTap: null,
              image: 'assets/svg/wallet.svg',
              countNotifications: 0),
          gapH12,
          _createDrawerItem(
              context: context,
              icon: Icons.settings,
              text: 'Mercadeo',
              onTap: null,
              image: 'assets/svg/mercadeo.svg',
              countNotifications: 0),
          gapH12,
          _createDrawerItem(
              context: context,
              icon: Icons.message,
              text: 'PQRS',
              onTap: null,
              image: "assets/svg/pqrs.svg",
              countNotifications: 0),
          gapH12,
          _createDrawerItem(
              context: context,
              icon: Icons.business_center,
              text: 'Salir',
              onTap: () => context.read<HomeCubit>().logout(),
              image: 'assets/svg/logout.svg',
              countNotifications: 0),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required BuildContext context,
      required IconData icon,
      required String image,
      required String text,
      int? countNotifications,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(image, height: 50, width: 50),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
          if (countNotifications! > 0) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 1, left: 20),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 238, 39, 24),
                radius: 16,
                child: Text('$countNotifications'),
              ),
            )
          ]
        ],
      ),
      onTap: onTap,
    );
  }
}
