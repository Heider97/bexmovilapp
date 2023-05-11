import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/cart/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is CartLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is CartSuccess) {
        return buildBody(size, state);
      } else {
        return const SizedBox();
      }
    }));
  }

  Widget buildBody(Size size, state) {
    if(state.products.isEmpty) {
      return const Center(
        child: Text('Agrega un producto'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: state.products.length,
      itemBuilder: (BuildContext context, index) {
        return Container();
      },
    );
  }
}
