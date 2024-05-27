import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubits
import '../../cubits/index/index_cubit.dart';

import '../atomsbox.dart';

class AppGlobalBottomNavBar extends StatelessWidget {
  const AppGlobalBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, IndexState>(builder: (context, state) {
      return AppBottomNavBar(
        currentIndex: state.index ?? 0,
        floating: true,
        items: [
          AppBottomNavBarItem(
            icon: Icons.home,
            label: 'Inicio',
            onTap: () => context.read<IndexCubit>().bottomTapped(0),
          ),
          AppBottomNavBarItem(
            icon: Icons.calendar_month,
            label: 'Agenda',
            onTap: () => context.read<IndexCubit>().bottomTapped(0),
          ),
          AppBottomNavBarItem(
              icon: Icons.people,
              label: 'Cliente',
              onTap: () => context.read<IndexCubit>().bottomTapped(0)),
        ],
      );
    });
  }
}
