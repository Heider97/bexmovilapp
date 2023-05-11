import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/product/product_cubit.dart';

//utils
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/extensions/string_extension.dart';

//features
import '../../../widgets/custom_icon_back.dart';
import '../home/features/product_widget.dart';

//widgets
import '../../../widgets/default_button_widget.dart';

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
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    state.product.image == null
                        ? Image.asset("assets/images/hero.png",
                            fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl: state.product.image,
                            placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator()),
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
              expandedHeight: 300,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: size.width,
                  height: size.height / 1.8,
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(state.product.name,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600)),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 20),
                                  children: [
                                    TextSpan(
                                      style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                      text: state.product.rating.toString(),
                                    ),
                                    const WidgetSpan(
                                      child: Icon(Icons.star, size: 25),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(state.product.description,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                          const SizedBox(height: 20),
                          Text(''.formatted(state.product.price),
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                      DefaultButton(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Añadir al carrito',
                                style: TextStyle(color: Colors.white)),
                            Icon(Icons.add_shopping_cart, color: Colors.white)
                          ],
                        ),
                        press: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: 30,
            left: 10,
            child: CustomIconBack(
              onPressed: () => context.read<ProductCubit>().back(),
            )),
      ],
    );
  }
}
