import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

//cubit
import '../../../cubits/category/category_cubit.dart';

//domain
import '../../../../domain/models/product.dart';

//features
import '../home/features/product_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key, required this.categoryId}) : super(key: key);

  final int categoryId;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late CategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.init(widget.categoryId);
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
        BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is CategorySuccess) {
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
                Text(state.category.name),
              ],
            ),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                state.category.image == null
                    ? Image.asset("assets/images/hero.png", fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: state.category.image,
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
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProductWidget(product: state.category.products[index]),
            );
          },
          childCount: state.category.products.length,
        )),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) => Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: ListTile(
        //           contentPadding:
        //               const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        //           tileColor: index.isOdd ? oddItemColor : evenItemColor,
        //           title: Text('Place ${index + 1}')),
        //     ),
        //     childCount: 30,
        //   ),
        // ),
      ],
    );
  }

  Widget category(index) => (index == 0)
      ? Container(
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.tertiaryContainer),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.brightness_7_outlined, size: 50),
                Text('Category $index',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('This is a popular plant in our store', maxLines: 2)
              ],
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.tertiaryContainer),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.brightness_7_outlined, size: 50),
                  Text('Category $index',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text('This is a popular plant in our store',
                      maxLines: 2)
                ],
              ),
            ),
          ),
        );
}
