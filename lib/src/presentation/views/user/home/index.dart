import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/index/index_cubit.dart';

//pages
import './pages/calendar.dart';
import './pages/clients.dart';
import './pages/home.dart';

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
