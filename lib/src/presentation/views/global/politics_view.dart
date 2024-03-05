//TODO [Heider Zapa] Organize
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

//utils
import '../../../utils/constants/nums.dart';

//cubit
import '../../cubits/politics/politics_cubit.dart';

// animation
import 'package:lottie/lottie.dart';

//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

//widgets
import '../../widgets/atoms/app_text.dart';
import '../../widgets/atoms/app_elevated_button.dart';

final NavigationService _navigationService = locator<NavigationService>();

class PoliticsView extends StatefulWidget {
  const PoliticsView({super.key});

  @override
  PoliticsViewState createState() => PoliticsViewState();
}

class PoliticsViewState extends State<PoliticsView> {
  bool isLoading = false;
  late PoliticsCubit politicsCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<PoliticsCubit, PoliticsState>(
        listener: (context, state) {
          if (state is PoliticsSuccess) {
            _navigationService.goTo(state.route!);
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: ListView(children: [
                    const SizedBox(height: 10),
                    Lottie.asset('assets/animations/47956-area-map.json',
                        height: 300, width: 300),
                    const SizedBox(height: 20),
                    const Text(
                        'Tu ubicación actual se mostrará en el mapa y se usará para rutas, búsquedas de sitios y estimaciones del tiempo de venta de tus pedidos.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 10),
                    const Text(
                        'Bex movil recopila datos de tu ubicación para habilitar el seguimiento continuo de los vendedores en la toma de pedidos y mejorar los tiempos de venta incluso cuando la aplicación esta cerrada o no esta en uso.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () => _launchUrl(Uri.parse(
                            'https://bexdeliveries.com/politicas-de-datos-terminos-y-condiciones')),
                        child: Text(
                            'Para ver nuestras politicas de privacidad haz click aquí',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w300))),
                    const SizedBox(height: 40),
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(theme.primaryColor),
                          )
                        : AppElevatedButton(
                            minimumSize: const Size(70, 70),
                            child: AppText('Aceptar y Continuar', fontSize: 20),
                            onPressed: () => _dispatchEvent(context),
                        )
                  ]),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<PoliticsCubit>(context).goTo();
  }
}
