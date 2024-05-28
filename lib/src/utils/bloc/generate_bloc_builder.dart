import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericBlocBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  final Type blocType;
  final Type stateType;
  final dynamic bloc;
  final dynamic Function(dynamic) blocBuilder;

  const GenericBlocBuilder({
    Key? key,
    required this.blocType,
    required this.stateType,
    required this.bloc,
    required this.blocBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      bloc: bloc,
      builder: (context, state) {
        if (state.runtimeType == stateType) {
          return blocBuilder(state);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
