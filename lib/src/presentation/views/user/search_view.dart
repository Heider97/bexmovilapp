import 'package:bexmovil/src/data/datasources/local/app_database.dart';

import 'package:bexmovil/src/domain/models/search_result.dart';

import 'package:bexmovil/src/presentation/blocs/search/search_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';

import 'package:bexmovil/src/presentation/widgets/user/search_result_card.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  final List<String> tables;
  const SearchView({super.key, required this.tables});

  @override
  State<SearchView> createState() => _SearchViewState();
}

late TextEditingController searchController;
late SearchBloc searchBloc;
late FocusNode searchFocusNode;
List<SearchResult> itemsToSearch = [];
List<SearchResult> itemsFounded = [];

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchFocusNode = FocusNode();

    fillRegisters(tables: widget.tables);
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Row(
              children: [
                const CustomBackButton(primaryColorBackgroundMode: true),
                gapW20,
                Expanded(
                  child: TextField(
                    focusNode: searchFocusNode,
                    controller: searchController,
                    onChanged: (value) async {
                      setState(() {
                        itemsFounded = itemsToSearch
                            .where((product) =>
                                product.name!.toLowerCase().contains(
                                    searchController.text.toLowerCase()) ||
                                product.code.toString().toLowerCase().contains(
                                    searchController.text.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          searchController.text.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text("No hay resultados disponibles"),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: itemsFounded.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final product = itemsFounded[index];

                      return SearchResultCard(
                        searchResult: product,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Puedes usar esta función para activar el foco en el TextField cuando se inicia la vista.
    searchFocusNode.requestFocus();
  }
}

Future<void> fillRegisters({required List<String> tables}) async {
  itemsToSearch.clear();

  final AppDatabase appDatabase = AppDatabase();

  for (String table in tables) {
    final db = await appDatabase.streamDatabase;
    final resultList = await db!.query(table);
    for (var result in resultList) {
      SearchResult item = SearchResult.fromJson(result, table);
      itemsToSearch.add(item);
    }
  }
}
