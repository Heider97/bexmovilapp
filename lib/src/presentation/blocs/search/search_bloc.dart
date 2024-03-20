import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/database_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final DatabaseRepository databaseRepository;

  SearchBloc(this.databaseRepository) : super(SearchState()) {
    on<ChangeTablesToSearch>(_changeTablesToSearch);
  }

  Future<List<Map<String, Object?>>> search(String table) {
    return databaseRepository.search(table);
  }

  _changeTablesToSearch(ChangeTablesToSearch event, Emitter emit) {
    emit(state.copyWith(tables: event.newTables));
  }
}
