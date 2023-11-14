/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaml/yaml.dart';

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

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, this.user, this.companyName}) : super(key: key);

  final String? companyName;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user != null ? user!.name! : 'No user'),
            accountEmail: Text(user != null ? user!.email! : 'No email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                user != null ? user!.name! : 'S',
                style: const TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
          ),
          _createDrawerItem(
              context: context,
              icon: Icons.business,
              text: companyName != null
                  ? companyName!.toUpperCase()
                  : 'Not found',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.help_center,
              text: 'Ver tutorial.',
              onTap: () {
                _storageService.setBool('home-is-init', false);
                _storageService.setBool('work-is-init', false);
                _storageService.setBool('navigation-is-init', false);
                _storageService.setBool('summary-is-init', false);
                _storageService.setBool('inventory-is-init', false);
              }),
          // _createDrawerItem(
          //     context: context,
          //     icon: Icons.bookmark_border,
          //     text: 'Mis pedidos',
          //     onTap: null),
          // _createDrawerItem(
          //     context: context,
          //     icon: Icons.money,
          //     text: 'Billetera',
          //     onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.calendar_month,
              text: 'Agenda',
              onTap: () => _navigationService.goTo(Routes.calendarRoute)),
          _createDrawerItem(
              context: context,
              icon: Icons.label_important,
              text: 'Productividad',
              onTap: () => _navigationService.goTo(Routes.productivityRoute)),
          _createDrawerItem(
              context: context,
              icon: Icons.settings,
              text: 'Configuración',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.logout,
              text: 'Salir',
              onTap: () async => await context.read<HomeCubit>().logout()),
          const Divider(),
          FutureBuilder(
              future: rootBundle.loadString('pubspec.yaml'),
              builder: (context, snapshot) {
                var version = 'Unknown';
                if (snapshot.hasData) {
                  var yaml = loadYaml(snapshot.data as String);
                  version = yaml['version'];
                }

                return AboutListTile(
                  icon: const Icon(
                    Icons.info,
                  ),
                  applicationIcon: const Icon(
                    Icons.local_play,
                  ),
                  applicationName: 'Bex movil',
                  applicationVersion: version,
                  applicationLegalese: '© 2023 Company',
                  child: const Text('Sobre la aplicación'),
                );
              }),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required BuildContext context,
      required IconData icon,
      required String text,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
 */