import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/presentation/cubits/home/home_bloc.dart';
import 'package:bexmovil/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final bloc = HomeBloc();

  @override
  void initState() {
    bloc.init(this);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: bloc,
            builder: (_, __) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Home Page',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            CircleAvatar(
                              radius: 17,
                              child: ClipOval(
                                child: Image.asset('assets/images/icon.png',
                                    height: 30, fit: BoxFit.cover),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: TabBar(
                          onTap: bloc.onTapSelected,
                          controller: bloc.tabController,
                          indicatorWeight: 0.1,
                          isScrollable: true,
                          tabs:
                              bloc.tabs.map((e) => TabWidget(tab: e)).toList()),
                    ),
                    Expanded(
                        child: ListView.builder(
                            controller: bloc.scrollController,
                            itemCount: bloc.items.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              final item = bloc.items[index];
                              if (item.isCategory) {
                                return CategoryWidget(category: item.category!);
                              } else {
                                return ProductWidget(product: item.product!);
                              }
                            }))
                  ],
                )),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.tab});

  final TabCategory tab;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: tab.selected ? 1 : 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          tab.category.name,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(category.name,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: productHeight,
      child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(product.image)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(product.description,
                        maxLines: 2, style: const TextStyle(fontSize: 11)),
                    const SizedBox(height: 5),
                    Text('\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
