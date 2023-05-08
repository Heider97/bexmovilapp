import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../cubits/home/home_cubit.dart';

//features
import 'features/category_widget.dart';
import 'features/category_image_widget.dart';
import 'features/product_widget.dart';

//widgets
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/end_drawer_widget.dart';

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
      drawer: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return DrawerWidget(user: state.user, companyName: state.companyName);
      }),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
            bloc: homeCubit,
            builder: (context, state) {
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
    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {},
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: 120,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextField(
                            autofocus: false,
                            style: const TextStyle(height: 0.5),
                            controller: TextEditingController(),
                            decoration: const InputDecoration(
                                labelText: "Buscar",
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: null,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 28,
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                TabBar(
                    onTap: context.read<HomeCubit>().onTapSelected,
                    controller: context.read<HomeCubit>().tabController,
                    indicatorWeight: 0.1,
                    isScrollable: true,
                    tabs: context
                        .read<HomeCubit>()
                        .tabs
                        .map((tab) => tabWidget(tab))
                        .toList()),
              ],
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
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
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
                          Positioned(
                              right: -25,
                              bottom: -55,
                              child:
                                  CategoryImageWidget(image: category.image)),
                          // CategoryImageWidget(image: category.image)
                        ],
                      ),
                    );
                  }))
        ]));
  }

  Widget tabWidget(tab) {
    return Opacity(
      opacity: tab.selected ? 1 : 0.7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          tab.category.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}
