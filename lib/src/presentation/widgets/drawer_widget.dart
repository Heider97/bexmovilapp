import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

//utils
import '../../utils/constants/strings.dart';

//domain
import '../../domain/models/user.dart';

//services
import '../../locator.dart';
import '../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

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
            accountEmail: Text(user != null ?  user!.email! : 'No email'),
            otherAccountsPictures: const [
              // IconButton(
              //     icon: Icon(
              //         themeNotifier.isDark
              //             ? Icons.nightlight_round
              //             : Icons.wb_sunny,
              //         color: Colors.white),
              //     onPressed: () {
              //       themeNotifier.isDark
              //           ? themeNotifier.isDark = false
              //           : themeNotifier.isDark = true;
              //     })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                user != null ? user!.name! :  'S',
                style: const TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
          ),
          _createDrawerItem(
              context: context,
              icon: Icons.business,
              text: companyName != null ? companyName!.toUpperCase() : 'Not found',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.help_center,
              text: 'Ver tutorial.',
              onTap: () {
                // _storageService.setBool('home-is-init', false);
                // _storageService.setBool('work-is-init', false);
                // _storageService.setBool('navigation-is-init', false);
                // _storageService.setBool('summary-is-init', false);
                // _storageService.setBool('inventory-is-init', false);
              }),
          _createDrawerItem(
              context: context,
              icon: Icons.bookmark_border,
              text: 'Mis pedidos',
              onTap: () => _navigationService.goTo(databaseRoute)),
          _createDrawerItem(
              context: context,
              icon: Icons.money,
              text: 'Billetera',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.chat,
              text: 'Mensajes',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.help_center,
              text: 'Ayuda',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.settings,
              text: 'Configuración',
              onTap: null),
          _createDrawerItem(
              context: context,
              icon: Icons.logout,
              text: 'Salir',
              onTap: null),
          const Divider(),
          //_createDrawerItem(icon: Icons.bug_report, text: 'Reportar un problema'),
          FutureBuilder(
              future: rootBundle.loadString('pubspec.yaml'),
              builder: (context, snapshot) {
                var version = 'Unknown';
                if (snapshot.hasData) {
                  var yaml = loadYaml(snapshot.data as String);
                  version = yaml['version'];
                }

                return ListTile(
                  title: Text(version),
                  onTap: () {},
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
