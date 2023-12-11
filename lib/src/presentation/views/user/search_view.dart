import 'package:bexmovil/src/data/datasources/local/app_database.dart';
import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/search_result.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/search/search_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_item.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

late TextEditingController searchController;
late SearchBloc searchBloc;
List<SearchResult> itemsToSearch = [];

class _SearchViewState extends State<SearchView> {
  @override
  void initState() async {
    super.initState();
    searchController = TextEditingController();
    searchBloc = BlocProvider.of<SearchBloc>(context);

    /*  
   await inserRegisters() */

    await fillRegisters(tables: searchBloc.state.tables!);
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

/*     Future<void> inserRegisters() async {

    final AppDatabase appDatabase = AppDatabase();
    appDatabase.insert('tblmcliente', {''>});
   
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Const.padding),
            child: Row(
              children: [
                CustomBackButton(mode: 1),
                gapW20,
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) async {
                      //TODO HACER LA VALIDACION DE CONTAIN CON EL LISTADO DE itemsToSearch

                      /*        List<Client> clients =
                          await _databaseRepository.getClients(); */

                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: searchController.text.isEmpty
                ? Center(
                    child: Text("No hay resultados disponibles"),
                  )
                : ListView.builder(
                    //TODO: LEER EL LISTADO DE OBJETOS DE TIPO ITEM SEARCH Y DIBUJARLOS.
                    itemCount: 2,
                    itemBuilder: (_, index) {
                      return _builUserCard(context);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _builUserCard(BuildContext context) {
    //TODO : UBICAR EL SWITCH CASE AQUI ....
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Screens.heigth(context) * 0.25,
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('asdasd'),
                          Text('asdasd'),
                          Text('asdasd'),
                          Text('asdasd')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(Const.space8)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 4, bottom: 4),
                        child: Center(
                          child: Text('Cliente'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: CustomItem(
                                iconName: 'Vender',
                                imagePath: 'assets/icons/vender.png'),
                          )),
                    ),
                    Expanded(
                      child: Card(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: CustomItem(
                                iconName: 'Mercadeo',
                                imagePath: 'assets/icons/mercadeo.png'),
                          )),
                    ),
                    Expanded(
                      child: Card(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: CustomItem(
                                iconName: 'Cartera',
                                imagePath: 'assets/icons/cartera.png'),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
