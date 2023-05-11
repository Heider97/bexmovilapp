import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../../../app_localizations.dart';
import '../../../cubits/home/home_cubit.dart';

//features
import 'features/category_widget.dart';
import 'features/category_image_widget.dart';
import 'features/product_widget.dart';

//widgets
import '../../../widgets/drawer_widget.dart';

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
          elevation: 0,
          title: Text(
              AppLocalization.of(context)
                  .getTranslatedValue("home_title")
                  .toString(),
              style: const TextStyle(fontSize: 16)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.list_sharp),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          actions: const [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: BlocSelector<HomeCubit, HomeState, bool>(
              selector: (state) =>
                  state.runtimeType == HomeSuccess ? true : false,
              builder: (context, booleanState) {
                if (booleanState) {
                  return TabBar(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black
                      ), //Change background color from here
                      onTap: context.read<HomeCubit>().onTapSelected,
                      controller: context.read<HomeCubit>().tabController,
                      indicatorWeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      tabs: context
                          .read<HomeCubit>()
                          .tabs
                          .map((tab) => tabWidget(tab))
                          .toList());
                } else {
                  return const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                }
              },
            ),
          )),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                        ),
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
                          child: CategoryImageWidget(image: category.image)),
                      // CategoryImageWidget(image: category.image)
                    ],
                  ),
                );
              }))
    ]);
  }

  Widget tabWidget(tab) {
    return Tab(
      text: tab.category.name,
    );
  }
}
