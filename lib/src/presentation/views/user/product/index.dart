import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/product/product_cubit.dart';

//domain
import '../../../../domain/models/product.dart';

//features
import '../home/features/product_widget.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late ProductCubit productCubit;

  @override
  void initState() {
    productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.init(widget.productId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(body:
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is ProductSuccess) {
        return buildBody(size, state);
      } else {
        return const SizedBox();
      }
    }));
  }

  Widget buildBody(Size size, state) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(state.product.name),
              ],
            ),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                state.product.image == null
                    ? Image.asset("assets/images/hero.png", fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: state.product.image,
                        placeholder: (context, url) =>
                            const Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Image.asset(
                              "assets/images/hero.png",
                              fit: BoxFit.cover,
                            )),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.5),
                      end: Alignment.center,
                      colors: <Color>[
                        Color(0x60000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          expandedHeight: 150,
        ),
        // SliverList(
        //     delegate: SliverChildBuilderDelegate(
        //           (BuildContext context, int index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 20),
        //           child: ProductWidget(product: state.category.products[index]),
        //         );
        //       },
        //       childCount: state.category.products.length,
        //     )),
      ],
    );
  }
}
