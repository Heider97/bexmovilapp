import 'package:bexmovil/src/presentation/cubits/index/index_cubit.dart';
import 'package:bexmovil/src/presentation/views/user/home/pages/calendar.dart';
import 'package:bexmovil/src/presentation/views/user/home/pages/clients.dart';
import 'package:bexmovil/src/presentation/views/user/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => IndexViewState();
}

class IndexViewState extends State<IndexView> {
  late IndexCubit indexCubit;

  @override
  void initState() {
    indexCubit = BlocProvider.of<IndexCubit>(context);
    super.initState();
  }

  Widget buildPageView(IndexState state) {
    return PageView(
      controller: state.pageController,
      onPageChanged: (index) {
        indexCubit.pageChanged(index);
      },
      children: const <Widget>[HomeView(), CalendarView(), ClientsView()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, IndexState>(builder: (context, state) {
      return buildPageView(state);
    });
  }
}
