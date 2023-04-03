
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//utils
import '../../../../utils/constants/strings.dart';

//features
import 'features/category_widget.dart';
import 'features/product_widget.dart';
import 'features/category_image_widget.dart';



class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.init(this);
    super.initState();
  }

  @override
  void dispose() {
    homeCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TR 38AA #59A-231', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is HomeSuccess) {
            return buildHome(state);
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget buildHome(state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 60,
        child: TabBar(
            onTap: context.read<HomeCubit>().onTapSelected,
            controller: context.read<HomeCubit>().tabController,
            indicatorWeight: 0.1,
            isScrollable: true,
            tabs: context.read<HomeCubit>().tabs.map((e) => TabWidget(tab: e)).toList()),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          padding: const EdgeInsets.all(20),
          height: 100,
          child: Row(
            children: const [
              Icon(Icons.lightbulb),
              Flexible(
                  child: Text('Aqui va toda la publicidad engañosa de la app',
                      maxLines: 2))
            ],
          ),
        ),
      ),
      Expanded(
          child: ListView.builder(
              controller: context.read<HomeCubit>().scrollController,
              itemCount: state.categories!.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final category = state.categories![index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //CATEGORY
                            CategoryWidget(category: category),
                            //PRODUCTS
                            ...List.generate(
                                category.products.length,
                                (index) => ProductWidget(
                                    product: category.products[index]))
                          ],
                        ),
                      ),
                      // CategoryImageWidget(image: category.image)
                    ],
                  ),
                );
              }))
    ]);
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}
