import '../cache_strategy.dart';
import '../cache_manager.dart';
import '../storage/storage.dart';

class JustAsyncStrategy extends CacheStrategy {
  static final JustAsyncStrategy _instance = JustAsyncStrategy._internal();

  factory JustAsyncStrategy() {
    return _instance;
  }

  JustAsyncStrategy._internal();

  @override
  Future<T?> applyStrategy<T>(
          AsyncBloc<T> asyncBloc,
          String key,
          SerializerBloc<T> serializerBloc,
          int ttlValue,
          Storage storage) async =>
      await invokeAsync(asyncBloc, key, storage);
}
