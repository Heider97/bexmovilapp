import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<ChangeTablesToSearch>(_changeTablesToSearch);
  }

  _changeTablesToSearch(ChangeTablesToSearch event, Emitter emit) {
    emit(state.copyWith(tables: event.newTables));
  }
}
