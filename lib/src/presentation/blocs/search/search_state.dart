part of 'search_bloc.dart';

class SearchState {
  final String? query;
  final List<String>? tables;
  SearchState({this.query, this.tables});

  SearchState copyWith({String? query, List<String>? tables}) =>
      SearchState(query: query ?? this.query, tables: tables ?? this.tables);
}
