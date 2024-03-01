import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//bloc
import '../../blocs/sync_features/sync_features_bloc.dart';

//utils
import '../../../utils/constants/gaps.dart';

//widgets
import '../../../presentation/widgets/global/app_card_feature.dart';
import '../../widgets/atoms/app_text.dart';
import '../../widgets/atoms/app_elevated_button.dart';

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
      syncFeaturesBloc.goToHome();
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
          AppText('Sincronizando', fontSize: 22, fontWeight: FontWeight.bold),
          const Text('Mientras esperas, conoce nuestras ultimas novedades. ',
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount:
                      state.features != null ? state.features!.length : 0,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: AppCardFeature(

                            axis: Axis.vertical,
                            text: state.features![index].descripcion!,
                            url: state.features![index].urldesc,
                            color:
                                index / 2 == 0 ? Colors.orange : Colors.green),
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
    return CountDown(
      target: DateTime.now().add(
        const Duration(minutes: 2),
      ),
    );
  }

  Widget _buildError(SyncFeaturesState state, theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText('!Ups Ocurrió un Error!',
            textAlign: TextAlign.center,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        gapH16,
        AppText(state.error ?? "Error", textAlign: TextAlign.center),
        gapH16,
        AppElevatedButton(
            minimumSize: const Size(150, 50),
            onPressed: () => syncFeaturesBloc.add(SyncFeatureGet()),
            child: AppText('Reintentar',
                fontWeight: FontWeight.bold, color: Colors.white))
      ],
    );
  }
}

class CountDown extends StatelessWidget {
  final DateTime target;

  const CountDown({
    Key? key,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Column(
          children: [
            AppText('Espere hasta ${DateFormat.Hms().format(target)}'),
            gapH24,
            AppText(target.difference(DateTime.now()).toString().split('.')[0])
          ],
        );
      },
    );
  }
}
