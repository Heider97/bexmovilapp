import 'package:bexmovil/src/presentation/blocs/sync_features/sync_features_bloc.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//widgets
import '../../../presentation/widgets/custom_card_widget.dart';
import '../../widgets/global/custom_elevated_button.dart';

class SyncView extends StatefulWidget {
  const SyncView({super.key});

  @override
  State<SyncView> createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  late SyncFeaturesBloc syncFeaturesBloc;

  @override
  void initState() {
    syncFeaturesBloc = BlocProvider.of<SyncFeaturesBloc>(context);
    syncFeaturesBloc.add(SyncFeatureGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<SyncFeaturesBloc, SyncFeaturesState>(
      builder: (context, state) => buildBlocConsumer(size, theme),
    );
  }

  Widget buildBlocConsumer(Size size, ThemeData theme) {
    return BlocConsumer<SyncFeaturesBloc, SyncFeaturesState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return _buildBody(size, theme, state);
      },
    );
  }

  void buildBlocListener(context, state) {
    if (state is SyncFeaturesSuccess) {
      // loginCubit.goToHome();
    }
  }

  Widget _buildBody(Size size, ThemeData theme, SyncFeaturesState state) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gapH64,
          const Text(
            'Sincronizado',
            style: TextStyle(fontSize: 22),
          ),
          const Text('Mientras esperas, conoce nuestras ultimas novedades. ',
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount:
                      state.features != null ? state.features!.length : 0,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomCard(
                            text: state.features![index].descripcion!,
                            color: Colors.orange),
                      ))),
          BlocSelector<SyncFeaturesBloc, SyncFeaturesState, bool>(
              selector: (state) => state is SyncFeaturesFailure,
              builder: (BuildContext context, booleanState) => !booleanState
                  ? _buildLoading(state, theme)
                  : _buildError(state, theme)),
          gapH64
        ],
      ),
    );
  }

  Widget _buildLoading(SyncFeaturesState state, theme) {
    return Column(
      children: [
        const Text("Porfavor espere..."),
        gapH8,
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(theme.primaryColor))
      ],
    );
  }

  Widget _buildError(SyncFeaturesState state, theme) {
    return Column(
      children: [
        const Text(
            '!Ups Ocurrió un Error! Parece que algo salió mal realizando la sincronización',
            style: TextStyle(fontSize: 22)),
        Text(state.error!),
        CustomElevatedButton(
          width: 150,
          height: 50,
          onTap: () => syncFeaturesBloc.add(SyncFeatureGet()),
          child: Text(
            'Reintentar',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
