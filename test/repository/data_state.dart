import 'package:mockito/mockito.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

abstract class MockDataState<T> extends Mock implements DataState {
  @override
  final T? data;
  @override
  final String? error;

  MockDataState({this.data, this.error});
}

class MockDataSuccess<T> extends MockDataState<T> {
  MockDataSuccess(T data) : super(data: data);
}

class MockDataFailed<T> extends DataState<T> {
  const MockDataFailed(String error) : super(error: error);
}