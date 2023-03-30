import 'package:bexmovil/src/data/repositories/base/dio_exeptions.dart';
import 'package:dio/dio.dart';

import '../cache_strategy.dart';
import '../cache_manager.dart';
import '../storage/storage.dart';

class AsyncOrCacheStrategy extends CacheStrategy {
  static final AsyncOrCacheStrategy _instance = AsyncOrCacheStrategy._internal();

  factory AsyncOrCacheStrategy() {
    return _instance;
  }

  AsyncOrCacheStrategy._internal();

  @override
  Future<T?> applyStrategy<T>(AsyncBloc<T> asyncBloc, String key, SerializerBloc<T> serializerBloc, int ttlValue, Storage storage) async => await invokeAsync(asyncBloc, key, storage).onError(
        (DioExceptions restError, stackTrace) async {
      if (restError == 403 || restError == 404) {
        storage.clear(prefix: key);
        return Future.error(restError);
      } else {
        return await fetchCacheData(key, serializerBloc, storage, ttlValue: ttlValue) ?? Future.error(restError);
      }
    },
  );
}