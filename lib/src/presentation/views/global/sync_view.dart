import 'package:bexmovil/src/presentation/blocs/sync_features/sync_features_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//widgets
import '../../../presentation/widgets/custom_card_widget.dart';

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
    if (state is SyncFeaturesSuccess || state is SyncFeaturesFailure) {
      if (state.error != null) {
        // buildSnackBar(context, state.error!);
      } else {
        // loginCubit.goToHome();
      }
    }
  }

  Widget _buildBody(Size size, ThemeData theme, SyncFeaturesState state) {

    List<Widget>? features = state.features?.map((e) =>
      CustomCard(
          text: e.description,
          color: Colors.orange),
    ).toList(growable: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Sincronizado',
          style: TextStyle(fontSize: 22),
        ),
        const Text('Mientras esperas, conoce nuestras ultimas novedades. ', textAlign: TextAlign.center),
        const SizedBox(height: 40),
        ...?features,
        // BlocSelector<SyncFeaturesBloc, SyncFeaturesState, bool>(
        //     selector: (state) => state is SyncFeaturesFailure,
        //     builder: (BuildContext context, booleanState) => booleanState ? CircularProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation(theme.primaryColor),
        //     ) : _buildError(state))
      ],
    );
  }

  Widget _buildError(SyncFeaturesState state) {
    return Column(
      children: [
        Text(state.error!)
      ],
    );
  }
}
