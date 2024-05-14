part of 'search_bloc.dart';

class SearchEvent {
  const SearchEvent();
}

class ChangeTablesToSearch extends SearchEvent {
  final List<String> newTables;
  const ChangeTablesToSearch({required this.newTables});
}
