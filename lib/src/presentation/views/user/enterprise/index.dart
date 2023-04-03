import 'package:flutter/material.dart';

import '../../../../domain/models/product.dart';
import '../home/features/product_widget.dart';

class EnterpriseView extends StatefulWidget {
  const EnterpriseView({Key? key}) : super(key: key);

  @override
  State<EnterpriseView> createState() => _EnterpriseViewState();
}

class _EnterpriseViewState extends State<EnterpriseView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Enterprise name'),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  "assets/images/hero.png",
                  fit: BoxFit.cover,
                ),
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
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 140,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(3, (index) => category(index)).toList(),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    10,
                    (index) => const ProductWidget(
                        product: Product(
                            categoryId: 0,
                            id: 0,
                            name: 'pizza',
                            description: 'original masa',
                            price: 200000,
                            image: 'assets/images/pizza.jpg'))),
              ),
            ),
          ),
        )
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
    ));
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
