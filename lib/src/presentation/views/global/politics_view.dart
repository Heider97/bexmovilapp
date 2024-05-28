import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

//utils
import '../../../utils/constants/nums.dart';
import '../../../utils/constants/gaps.dart';

//cubit
import '../../cubits/politics/politics_cubit.dart';

//widgets
import '../../widgets/atomsbox.dart';

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
    politicsCubit = BlocProvider.of<PoliticsCubit>(context);
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
            politicsCubit.navigationService.goTo(state.route!);
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppIconText(
                            path: 'assets/icons/map.svg', messages: []),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            AppText(
                                'Tu ubicación actual se mostrará en el mapa y se usará para rutas, búsquedas de sitios y estimaciones del tiempo de venta de tus pedidos.',
                                textAlign: TextAlign.justify,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            gapH12,
                            AppText(
                                'Bex movil recopila datos de tu ubicación para habilitar el seguimiento continuo de los vendedores en la toma de pedidos y mejorar los tiempos de venta incluso cuando la aplicación esta cerrada o no esta en uso.',
                                textAlign: TextAlign.justify,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            gapH12,
                            InkWell(
                                onTap: () => _launchUrl(Uri.parse(
                                    'https://bexdeliveries.com/politicas-de-datos-terminos-y-condiciones')),
                                child: AppText(
                                    'Para ver nuestras politicas de privacidad haz click aquí',
                                    textAlign: TextAlign.justify,
                                    color: theme.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.primaryColor),
                              )
                            : AppElevatedButton(
                                minimumSize: const Size(70, 70),
                                child: AppText('Aceptar y Continuar',
                                    fontSize: 20),
                                onPressed: () => _dispatchEvent(context),
                              ),
                        gapH20
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
