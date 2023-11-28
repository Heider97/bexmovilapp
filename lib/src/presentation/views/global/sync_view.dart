import 'package:bexmovil/src/presentation/blocs/sync_features/sync_features_bloc.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          const Text(
            'Sincronizado',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomCard(
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
        const Duration(minutes: 5),
      ),
    );
  }

  Widget _buildError(SyncFeaturesState state, theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('!Ups Ocurrió un Error!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        gapH16,
        Text(state.error!, textAlign: TextAlign.center),
        gapH16,
        CustomElevatedButton(
          width: 150,
          height: 50,
          onTap: () => syncFeaturesBloc.add(SyncFeatureGet()),
          child: Text(
            'Reintentar',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
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
            Text('Time until ${DateFormat.Hms().format(target)}'),
            const SizedBox(height: 24.0),
            Text(target.difference(DateTime.now()).toString().split('.')[0]),
          ],
        );
      },
    );
  }
}
