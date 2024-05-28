import 'package:flutter/cupertino.dart';

import '../../../../widgets/atoms/app_text.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  State<ClientsView> createState() => ClientsViewState();
}

class ClientsViewState extends State<ClientsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Center(child: AppText('Proximamente!')),
      ),
    );
  }
}